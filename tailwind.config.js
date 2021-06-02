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
      },
      secondary: {
        DEFAULT: '#9E948B',
        50: '#FFFFFF',
        100: '#FBFAFA',
        200: '#E4E1DE',
        300: '#CCC7C3',
        400: '#B5AEA7',
        500: '#9E948B',
        600: '#867A70',
        700: '#6A6159',
        800: '#4E4842',
        900: '#332E2A'
      }
    },
    extend: {
      spacing: {
        30: '7.5rem'
      }
    }
  },
  variants: {
    extend: {
      display: ['group-hover']
    }
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('tailwindcss-skip-link')()
  ]
};
