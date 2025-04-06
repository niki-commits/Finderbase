self.addEventListener('install', event => {
    console.log('[SW] Installed');
    self.skipWaiting();
  });
  
  self.addEventListener('activate', event => {
    console.log('[SW] Activated');
    return self.clients.claim();
  });
  
  self.addEventListener('fetch', event => {
    console.log('[SW] Fetching:', event.request.url);
    event.respondWith(
      caches.match(event.request).then(response => {
        return response || fetch(event.request);
      })
    );
  });
  
  self.addEventListener('sync', event => {
    if (event.tag === 'sync-finderbase') {
      console.log('[SW] Sync triggered:', event.tag);
      event.waitUntil(doBackgroundSync());
    }
  });
  
  async function doBackgroundSync() {
    console.log('[SW] Doing background sync...');
    // You could fetch to your API here or sync local data
    await new Promise(resolve => setTimeout(resolve, 1000)); // Simulated delay
    console.log('[SW] Background sync complete');
  }
  
  self.addEventListener('push', event => {
    const data = event.data ? event.data.text() : '🔔 You have a new notification!';
    console.log('[SW] Push received:', data);
    event.waitUntil(
      self.registration.showNotification('FinderBase', {
        body: data,
        icon: 'icons/Icon-192.png',
      })
    );
  });
  
  self.addEventListener('message', event => {
    if (event.data?.type === 'simulate-push') {
      console.log('[SW] Simulating push');
      self.registration.showNotification('FinderBase', {
        body: event.data.data,
        icon: 'icons/Icon-192.png',
      });
    }
  });
  