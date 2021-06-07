/**
 * Alert banner
 */

export function initAlertBanners() {
  const alertBanners = document.querySelectorAll('.alert-banner');
  const bannerIds = [];
  const sessionStorage = window.sessionStorage;

  for (const banner of alertBanners) {
    const dismissButton = banner.querySelector('button');

    // Remove the banner if it has already been dismissed otherwise show it
    if (sessionStorage.getItem(`${banner.id}-dismissed`)) {
      banner.remove();
    } else {
      banner.classList.remove('alert-banner--hidden');
    }

    // Remove the banner when it is clicked and note that in session storage
    dismissButton.addEventListener('click', () => {
      sessionStorage.setItem(`${banner.id}-dismissed`, '1');
      banner.remove();
    });

    // Console log any banners with duplicate ids
    if (!bannerIds.includes(banner.id)) {
      bannerIds.push(banner.id);
    } else {
      const conflictingBanners = document.querySelectorAll(
        `#${banner.id}.alert-banner`
      );
      console.warn(
        `A banner with id: "${banner.id}" already exists.`,
        conflictingBanners
      );
    }
  }
}
