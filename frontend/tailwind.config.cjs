/* eslint-disable @typescript-eslint/no-var-requires */
const daisyui = require('daisyui');
const typography = require('@tailwindcss/typography');
const forms = require('@tailwindcss/forms');
const defaultTheme = require('tailwindcss/defaultTheme')

/** @type {import('tailwindcss').Config}*/
const config = {
	content: ['./src/**/*.{html,js,svelte,ts}'],

	theme: {
		fontSize: {
			...defaultTheme.spacing
		},
		screens: {
			'ipad': '768px',
			'lg': '1024px',
			'xl': '1280px',
			'2xl': '1536px',
		}
	},

	daisyui: {
		themes: [{
			light: {
				...require("daisyui/src/theming/themes")["light"],
				"neutral": "#3d4451",
				"base-100": "#F5F5F4",
				"base-200": "#E7E5E4",
				"base-300": "#78716C",
				"base-content": "#1C1917",
			},
			dark: {
				...require("daisyui/src/theming/themes")["dark"],
				"neutral": "#3d4451",
				"base-100": "#1C1917",
				"base-200": "#292524",
				"base-300": "#78716C",
				"base-content": "#E7E5E4",
				"--rounded-box": "5rem",
			},
		}],
	},

	plugins: [forms, typography, daisyui]
};

module.exports = config;
