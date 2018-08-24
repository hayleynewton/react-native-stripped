import React from 'react';
import {StyleSheet, View, ViewPropTypes} from 'react-native';

class Separator extends React.Component {

  render() {
    return (
      <View style={[styles.Container, this.props.style]}/>
    )
  }
}

Separator.propTypes = {
  style: ViewPropTypes.style
}

const styles = StyleSheet.create({
  Container: {
    width: '100%',
    height: 1,
  }
})

export default Separator;