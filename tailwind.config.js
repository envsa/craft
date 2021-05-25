module.exports = {
  // mode: 'jit',
  darkMode: false, // or 'media' or 'class',
  purge: {
    // https://tailwindcss.com/docs/optimizing-for-production
    content: [
      './src/js/**/*.{js,ts}',
      './src/vue/**/*.{vue,html}',
      './templates/**/*.{twig,html}'
    ],
    layers: ['base', 'components', 'utilities'],
    mode: 'layers',
    options: {
      safelist: [/^ff-/],
      whitelist: ['./src/css/components/*.css']
    }
  },
  theme: {
    extend: {}
  },
  variants: {
    extend: {}
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('tailwindcss-skip-link')()
  ]
};
