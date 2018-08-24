import React from 'react';
import {Provider} from 'mobx-react';
import AppStackNavigator from './Navigation/AppStackNavigator/AppStackNavigator.js';
import RootStackNavigator from './Navigation/RootStackNavigator/RootStackNavigator.js';
import AppDataStore from './Stores/AppDataStore.js';
import UIStore from './Stores/UIStore.js';

const stores = {
  uiStore: UIStore,
  appDataStore: AppDataStore
}

class App extends React.Component {
  render() {
    //return <RootStackNavigator />;
    return (
      <Provider {...stores}>
        <RootStackNavigator />
      </Provider>
    );
  }
}

export default App;