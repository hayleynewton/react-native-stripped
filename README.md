# Symbol Scan | Client

This is the first draft of the **Symbol Scan** React Native Client project.

## Project Structure

```
├── Application/ # All of React Native code.
│   ├── Views/ # Native Views for both platforms.
│   ├── Components/ # Components that are used for multiple screens.
│   ├── Screens/ # Individual screens and their components.
│   │   ├── SCREEN_NAME/
│   │   │   ├── SCREEN_NAME_Screen.js
│   │   │   └── ... # Components composed in this screen.
│   │   └── ...
│   ├── App.js # Entry point.
│   └── ...
└── ...
```

## Style

1. Prefer functional components where no `state` is required.
2. Props in JSX
  - Components with `props.length <= 2` should have them inlined.
```JSX
<Component color="blue" emotion="happy" />
```
  - Components with `props.length > 2` must break line for each one.
```JSX
<Component
  color="blue"
  emotion="happy"
  count={10} />
```
  - Value props go first, then action props
```JSX
<Component
  color="blue"
  onChange={() => console.log('Changes!')} />
```
  - Static props of type `string` should be put in quotes `""`.
  - Static props of any other type must be put in braces `{}`.
  - Always leave a ` ` (space) before terminating components without a closing
  tag.
```JSX
// Good
<Component
  color="blue"
  onChange={() => console.log('Changes!')} />
// Bad
<Component
  color="blue"
  onChange={() => console.log('Changes!')}/>
// Bad
<Component
  color="blue"
  onChange={() => console.log('Changes!')}
/>
```
3. All `import` statements need to be placed at the top of each file.
4. All `export` statements need to be placed at the bottom of each file.
5. Naming
  - Class like things (Components, Views, etc.) need to be suffixed with type.
```
EntryScreen.js --> class EntryScreen {}
SCNView.js
```
  - Use `on` to prefix action callback methods.
```JavaScript
onTap() {}
onExerciseStart() {}
```
6. All local imports need to have their extensions.
```JavaScript
import SomeScreen from './SomeScreen.js';
```