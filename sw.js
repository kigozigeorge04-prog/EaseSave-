console.log('🔄 Service Worker script loaded');

const CACHE_NAME = 'easesave-v1';
const urlsToCache = [
  './',
  './index.html',
  './manifest.json'
];

console.log('📦 Caching these files:', urlsToCache);

self.addEventListener('install', event => {
  console.log('🔄 Service Worker: Install event');
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        console.log('📦 Cache opened, adding files...');
        return cache.addAll(urlsToCache);
      })
      .then(() => {
        console.log('✅ All files cached successfully');
        return self.skipWaiting();
      })
      .catch(err => {
        console.error('❌ Installation failed:', err);
        throw err; // fail installation if caching fails
      })
  );
});

self.addEventListener('activate', event => {
  console.log('🔄 Service Worker: Activate event');
  const cacheWhitelist = [CACHE_NAME];
  event.waitUntil(
    caches.keys().then(cacheNames => {
      console.log('📦 Current caches:', cacheNames);
      return Promise.all(
        cacheNames.map(cacheName => {
          if (!cacheWhitelist.includes(cacheName)) {
            console.log('🗑️ Deleting old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
    .then(() => {
      console.log('✅ Service Worker activated');
      return self.clients.claim();
    })
    .then(() => {
      console.log('✅ Clients claimed');
    })
    .catch(err => {
      console.error('❌ Activation failed:', err);
    })
  );
});

self.addEventListener('fetch', event => {
  const url = new URL(event.request.url);

  // Only handle HTTP/HTTPS requests
  if (!url.protocol.startsWith('http')) {
    console.log('⏭️ Skipping non‑http request:', url.protocol);
    event.respondWith(fetch(event.request));
    return;
  }

  // Only cache GET requests
  if (event.request.method !== 'GET') {
    console.log(`⏭️ Skipping non‑GET request: ${event.request.method}`);
    event.respondWith(fetch(event.request));
    return;
  }

  // Optional: reduce logging for static assets
  const isStatic = url.pathname.match(/\.(js|css|png|jpg|jpeg|svg|ico)$/);
  if (!isStatic) {
    console.log(`🌐 Fetching: ${event.request.url}`);
  }

  event.respondWith(
    caches.match(event.request)
      .then(cachedResponse => {
        if (cachedResponse) {
          return cachedResponse;
        }

        return fetch(event.request)
          .then(networkResponse => {
            if (
              networkResponse &&
              networkResponse.status === 200 &&
              networkResponse.type === 'basic'
            ) {
              const responseToCache = networkResponse.clone();
              caches.open(CACHE_NAME).then(cache => {
                cache.put(event.request, responseToCache);
              });
            }
            return networkResponse;
          })
          .catch(err => {
            console.warn('⚠️ Network fetch failed, returning offline fallback:', err);
            return new Response('You are offline', {
              status: 503,
              headers: { 'Content-Type': 'text/plain' }
            });
          });
      })
  );
});

console.log('✅ Service Worker setup complete');
