import {AppRegistry, YellowBox} from 'react-native';
import App from './Application/App.js';

YellowBox.ignoreWarnings([
  // Remove the `isMounted(...)` deprecation warning (origin: react-navigation).
  'Warning: isMounted(...) is deprecated',
  // https://github.com/facebook/react-native/issues/17504
  'Module RCTImageLoader requires main queue setup',
  // https://github.com/facebook/react-native/issues/18201
  'Class RCTCxxModule was not exported.'
])

AppRegistry.registerComponent('SymbolScanClient', () => App);
