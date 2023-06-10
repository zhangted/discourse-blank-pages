# Discourse Blank Pages Plugin
Create blank pages on predefined routes and load external js on those pages.

## Plugin Admin Settings
- Routes
  - Define your list of valid routes (prefixed with '/page')
- External JS script link
  - Load a js script on valid routes

## Info
- Great for loading Preact (4kb) + frontend scripts + custom router scripts into some Discourse pages, to render custom pages / components.
- Valid routes will start with a div on the page with the route as id

## Troubleshoot
- Policy issue when loading script => Add cdn to discourse admin setting "content security policy script src"