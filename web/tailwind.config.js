/** @type {import('tailwindcss').Config} */
module.exports = {
    content: [
        "./app/**/*.{js,jsx}",
        "./pages/**/*.{js,jsx}",
        "./components/**/*.{js,jsx}",
    ],
    theme: {
        extend: {},
    },
    plugins: [],
    experimental: {
        usePostcssParser: true, // 👈 Tắt lightningcss
    },
}