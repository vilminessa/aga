// https://www.youtube.com/watch?v=Zb2QA71GLEQ
// https://getbootstrap.com/docs/5.3/customize/color-modes/

// TODO: Fix the FOUC

// LocalStorage get and set functions
const getStoredTheme = () => localStorage.getItem('theme')
const setStoredTheme = theme => localStorage.setItem('theme', theme)

// Get html elements
const themeCheckbox = document.getElementById('theme-checkbox')

// Get main html element
const html = document.getElementById('htmlPage')

// If we have theme in LS, then set it. If not - set it by system setting
const getPreferredTheme = () => {
	const storedTheme = getStoredTheme()
	if (storedTheme) {
		return storedTheme
	}
	return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
}

// Set theme, save it to LS
const setTheme = theme => {
	html.setAttribute('data-bs-theme', theme)
	setStoredTheme(theme)
}

// When page is loaded - set the theme
window.addEventListener('DOMContentLoaded', () => {
	const theme = getPreferredTheme()
	setTheme(theme)
})

// If checkbox has changed - change the theme
themeCheckbox.addEventListener('change', () => {
	const theme = themeCheckbox.checked ? 'light' : 'dark'
	setTheme(theme)
})
