// Check that service workers are supported
if ('serviceWorker' in navigator) {
  // Use the window load event to keep the page load performant
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('/service-worker.js', { scope: '/' })
      .then((registration) => {
        console.log(`👍 Service worker registration successful with scope: ${registration.scope}`);
      })
      .catch((error) => {
        console.warn(`Service worker failed to register: ${error}`);
      });
  });
}
