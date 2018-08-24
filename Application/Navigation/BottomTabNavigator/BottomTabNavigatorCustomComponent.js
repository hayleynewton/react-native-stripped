import React from 'react';
import {StyleSheet, View, TouchableOpacity, Text} from 'react-native';
import PropTypes from 'prop-types';
import Icon from '../../Components/Icon.js';
import * as ColorPallete from '../../ColorPallete.js'; 

const Constants = {
  icon: {
    size: 30,
    color: ColorPallete.WHITE
  }
};

class BottomTabNavigatorCustomComponent extends React.Component {

  constructor() {
    super();
    this.tabBarOptions = [
      {screen: 'Scan', icon: 'scan', text: 'Scan'},
    ]
  }

  render() {

    const navigation = this.props.navigation;
    const currentRouteName = navigation.state.routes[navigation.state.index].routeName;
    const iconContainerStyle = {flex: 1 / this.tabBarOptions.length};

    return(
      <View style={styles.Container}>
        {
          this.tabBarOptions.map((option, index) => {
            return <TouchableOpacity 
              key={'tabOption' + index}
              style={[styles.IconContainer, iconContainerStyle]} 
              onPress={() => navigation.navigate(option.screen, {tabNavigation: navigation})}>
              <View style={currentRouteName === option.screen && styles.Shadow}>
                <Icon 
                  name={option.icon}
                  size={Constants.icon.size} 
                  color={Constants.icon.color} />
              </View>
              <Text style={[styles.Text, currentRouteName === option.screen ? styles.TextBold : styles.TextRegular]}>{option.text}</Text>
            </TouchableOpacity>
          })
        }
      </View>
    );
  }
}

BottomTabNavigatorCustomComponent.propTypes = {
  navigation: PropTypes.object
}

const styles = StyleSheet.create({
  Container: {
    height: 60,
    width: '100%',
    flexDirection: 'row',
    backgroundColor: ColorPallete.TURQUOISE_LIGHT
  },

  IconContainer: {
    alignItems: 'center',
    justifyContent: 'center'
  },

  Image: {
    resizeMode: 'contain',
    width: 35,
    height: 35
  },

  Text: {
    color: ColorPallete.WHITE,
    fontSize: 14
  },

  TextRegular: {
    fontFamily: 'SourceSansPro-Regular'
  },

  TextBold: {
    fontFamily: 'SourceSansPro-Bold'
  },

  Shadow: {
    shadowRadius: 3,
    shadowOffset: {height: 3, width: 2},
    shadowColor: 'black',
    shadowOpacity: 0.5
  }
});

export default BottomTabNavigatorCustomComponent;
