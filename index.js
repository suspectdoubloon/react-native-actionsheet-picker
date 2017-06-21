import ReactNative from 'react-native';

const {
  NativeModules: {
    CJActionSheetPicker,
  }
} = ReactNative;

const {
  showCountDownPicker,
  showStringPicker,
  showDatePicker,
  showTimePicker
} = CJActionSheetPicker;

export { showCountDownPicker, showStringPicker, showDatePicker, showTimePicker };
