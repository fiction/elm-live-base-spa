## Setup
Clone into new folder 
`git clone git@github.com:fiction/elm-line-base-spa.git my-elm-project`

### Re-initialize the project folder as your own repo:
  ```
  rm -rf .git
  git init
  git add .
  git commit -m 'first commit'
  ``` 

## Development

### Run Elm Live for auto reloading with pushstate
1. `elm make` to get Elm dependencies
1. `elm-live --pushstate src/Main.elm --output=dist/elm.js`
1. Open http://localhost:8000

### Build Project
Note: this process is taken directly from (The Elm Guide)[https://guide.elm-lang.org/optimization/asset_size.html]
1. Run `elm make src/Main.elm --optimize --output=elm.js` to build Elm files into `dist/elm.js`
1. Run `uglifyjs dist/elm.js --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output=dist/elm.min.js` to minify the `elm.js` file

### Todo
- Replace index.html in root folder once the fix is out for auto reloading
