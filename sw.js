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
        return cache.addAll(urlsToCache)
          .then(() => {
            console.log('✅ All files cached successfully');
          })
          .catch(err => {
            console.error('❌ Failed to cache files:', err);
          });
      })
      .then(() => {
        console.log('✅ Service Worker installed');
        return self.skipWaiting();
      })
      .catch(err => {
        console.error('❌ Installation failed:', err);
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
  
  // Skip requests that are not http/https (like chrome-extension, moz-extension, etc.)
  if (!url.protocol.startsWith('http')) {
    console.log('⏭️ Skipping non-http request:', url.protocol);
    // Just fetch normally without caching
    event.respondWith(fetch(event.request));
    return;
  }

  // Log only non-static requests to avoid spam (optional)
  if (!url.pathname.includes('.js') && !url.pathname.includes('.css') && !url.pathname.includes('.png')) {
    console.log(`🌐 Fetching: ${event.request.url}`);
  }
  
  event.respondWith(
    caches.match(event.request)
      .then(cachedResponse => {
        if (cachedResponse) {
          // console.log('✅ Cache hit:', event.request.url);
          return cachedResponse;
        }
        // console.log('🌐 Network fetch:', event.request.url);
        return fetch(event.request)
          .then(networkResponse => {
            // Check if we got a valid response and it's a basic type (not opaque)
            if (networkResponse && networkResponse.status === 200 && networkResponse.type === 'basic') {
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
