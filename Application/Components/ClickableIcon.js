import React from 'react';
import {StyleSheet, Text, TouchableOpacity, ViewPropTypes} from 'react-native';
import PropTypes from 'prop-types';
import Icon from '../Components/Icon.js';
import * as ColorPallete from '../ColorPallete.js';

class ClickableIcon extends React.Component {

  render() {

    const {style, onClick, iconName, color, size} = this.props;

    return(
      <TouchableOpacity 
          style={[styles.Container, this.props.style]} 
          onPress={() => onClick()}>
          <Icon name={iconName} color={color} size={size} />
      </TouchableOpacity>
    );
  }
}

ClickableIcon.propTypes = {
  style: ViewPropTypes.style,
  iconName: PropTypes.string.isRequired,
  color: PropTypes.string,
  size: PropTypes.number,
  onClick: PropTypes.func.isRequired,
};

ClickableIcon.defaultProps = {
  color: ColorPallete.WHITE,
  size: 25
};

const styles = StyleSheet.create({
  Container: {
    justifyContent: 'center',
    alignItems: 'center',
    height: 40,
    width: 40
  }
})

export default ClickableIcon;