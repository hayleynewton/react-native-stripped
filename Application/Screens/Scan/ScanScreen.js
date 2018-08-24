import React from 'react';
import {View, StyleSheet} from 'react-native';

import ClickableIcon from '../../Components/ClickableIcon.js';

class ScanScreen extends React.Component {

  handleOnClose() {
    this.props.navigation.goBack();
  }

  render() {
    return (
      <View style={{flex: 1}}>

        <ClickableIcon 
          iconName="close" 
          size={30}
          style={styles.CloseButton} 
          onClick={() => this.handleOnClose()} />

      </View>
    );
  }
}

const styles = StyleSheet.create({
  CloseButton: {
    position: 'absolute',
    top: 20,
    left: 10,
    zIndex: 1
  }
});

export default ScanScreen;