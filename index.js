import ReactNative from 'react-native';

const {
  NativeModules: {
    CJActionSheetPicker,
  }
} = ReactNative;

const {
  showCountDownPicker,
  showStringPicker,
  showDatePicker
} = CJActionSheetPicker;

export { showCountDownPicker, showStringPicker, showDatePicker };
