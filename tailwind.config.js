/* eslint-disable quote-props */

module.exports = {
  theme: {
    // Extend the default Tailwind config here
    extend: {
    },
    // Replace the default Tailwind config here
    fontWeight: {
      normal: 400,
      bold: 700
    },
    fontFamily: {
      // We want to override these font stacks in the generic/global.scss file
      heading: ['dewnrger', 'sans-serif'],
      body: ['proxima-nova', 'sans-serif']
    },
    screens: {
      sm: '576px',
      md: '768px',
      lg: '992px',
      xl: '1200px'
    },
    aspectRatio: {
      'square': [1, 1],
      '4/3': [4, 3],
      '16/9': [16, 9],
      '21/9': [21, 9]
    }
  },
  variants: {
    backgroundColor: ['responsive', 'hover', 'focus', 'active', 'group-hover'],
    textDecoration: ['responsive', 'hover', 'focus', 'active', 'group-hover']
  },
  corePlugins: {},
  plugins: [
    require('tailwindcss-aspect-ratio')()
  ]
};
