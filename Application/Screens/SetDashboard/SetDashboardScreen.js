import React from 'react';
import {StyleSheet, View} from 'react-native';

import {dashboardStackNavigationOptions} from '../../Navigation/DashboardStackNavigator/DashboardStackNavigatorOptions';
import * as ColorPallete from '../../ColorPallete.js';


class SetDashboard extends React.Component {

  static navigationOptions = dashboardStackNavigationOptions("App", ColorPallete.TURQUOISE_LIGHT, false);

  render() {
    
    return(
      <View style={styles.Container}>
        
      </View>
    );
  }
}

const styles = StyleSheet.create({
  Container: {
    flex: 1,
    backgroundColor: ColorPallete.WHITE,
  },
});

export default SetDashboard;