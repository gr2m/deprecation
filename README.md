# deprecation

> Log a deprecation message with stack

## Usage

```js
const Deprecation = require('deprecation')

function foo () {
  bar()
}

function bar () {
  baz() 
}

function baz () {
  console.log(new Deprecation('[my-lib] foo() is deprecated, use bar()'))
}

foo()
// { Deprecation: [my-lib] foo() is deprecated, use bar()
//     at baz (/path/to/file.js:12:15)
//     at bar (/path/to/file.js:8:3)
//     at foo (/path/to/file.js:4:3)
```

## License

[ISC](LICENSE)