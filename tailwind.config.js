module.exports = {
  purge: {
    // https://tailwindcss.com/docs/optimizing-for-production
    content: [
      './src/js/**/*.js',
      './src/js/**/*.vue',
      './templates/goodliving/**/*.twig'
    ],
    options: {
      safelist: [/^ff-/]
    }
  },
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {}
  },
  variants: {
    extend: {}
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio')
  ]
};
