// From https://web.dev/browser-level-image-lazy-loading/#how-do-i-handle-browsers-that-don't-yet-support-lazy-loading
if ('loading' in HTMLImageElement.prototype) {
  // Replace the img.src with what is in the data-src property
  const images = document.querySelectorAll('img[loading="lazy"]');
  for (let i = 0; i < images.length; i++) {
    const img = images[i];
    img.src = img.dataset.src;
  }
  // Replace the source.srcset with what is in the data-srcset property
  const sources = document.querySelectorAll('source[data-srcset]');
  for (let i = 0; i < sources.length; i++) {
    const source = sources[i];
    source.srcset = source.dataset.srcset;
  }
} else {
  // Dynamically import the LazySizes libraray
  const script = document.createElement('script');
  script.src =
    'https://cdnjs.cloudflare.com/ajax/libs/lazysizes/5.1.2/lazysizes.min.js';
  document.body.appendChild(script);
}
