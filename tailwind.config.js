const { blue } = require('tailwindcss/colors');
const colors = require('tailwindcss/colors');

const customColors = {
  transparent: 'transparent',
  current: 'currentColor',
  black: colors.black,
  white: colors.white,
  gray: colors.trueGray,
  indigo: colors.indigo,
  blue: colors.blue
};

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
    colors: {
      ...customColors,
      primary: {
        DEFAULT: '#217B73',
        50: '#79DBD2',
        100: '#69D7CD',
        200: '#48CEC2',
        300: '#32BBAF',
        400: '#2A9B91',
        500: '#217B73',
        600: '#1B635C',
        700: '#144B46',
        800: '#0E332F',
        900: '#071A19'
      }
    },
    extend: {
      spacing: {
        30: '7.5rem'
      }
    }
  },
  variants: {
    extend: {},
    display: ['group-hover']
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('tailwindcss-skip-link')()
  ]
};
