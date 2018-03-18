/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  NativeModules,
  Platform,
  StyleSheet,
  Text,
  View,
  TextInput,
  Button,
  Alert,
  TouchableOpacity,
  Keyboard
} from 'react-native';

var walletManager = NativeModules.WalletManager;
var navigationHelper = NativeModules.NavigationHelper;

type Props = {};
export default class PayView extends Component<Props> {

  constructor(props){
    super(props);
    this.state = {targetAddress:"", amount:""};
  }

async tapSend() {
      var targetAddress = this.state.targetAddress;
      var amount = this.state.amount;
      var walletId = this.props.walletModelDict.walletId;
      if(targetAddress.length == 0) {
          Alert.alert("address is invalid");
      } else if (amount.length == 0) {
          Alert.alert("amount is invalid");
      } else {
          Keyboard.dismiss();
          console.log('send sky');
          var ret = await walletManager.sendSkyCoinWithWalletId(walletId, targetAddress, amount);

          if(ret == 'success') {
               Alert.alert('send sky success', 
               '',
            [{text:'OK', onPress:()=>{
                            navigationHelper.popToRootViewControllerAnimated(true);
                         }
             }
            ]);
              //navigationHelper.popToRootViewControllerAnimated(true);
          } else {
              Alert.alert('fail to send sky', ret);
              // navigationHelper.popToRootViewControllerAnimated(true);
          }
      }
  }

  async tapCancel() {
      navigationHelper.popViewControllerAnimated(true);
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Send Sky
        </Text>
        <Text style={styles.subTitle}>
        Walet
        </Text>
        <Text style={styles.subTitleWallet}>
            {this.props.walletModelDict.walletName + ' -' + this.props.balance}
        </Text>
        <Text style={styles.subTitle}>
        Send to
        </Text>
        <TextInput
                style={styles.textInput}
                onChangeText={
                    (text) => {
                        this.setState({ targetAddress: text });
                    }
                }
            >
        </TextInput>
        <Text style={styles.subTitle}>
            Amount
        </Text>
        <TextInput
                style={styles.textInput}
                onChangeText={
                    (text) => {
                        this.setState({ amount: text });
                    }
                }
            >
        </TextInput>
        <Text style={styles.subTitle}>
            Notes
        </Text>
        <TextInput
                style={styles.textInput}
                placeholder='Short description of transaction'
            >
        </TextInput>
        <View style={{flexDirection:'row', justifyContent: 'center'}}>
        <TouchableOpacity style={styles.cancelButton} onPress={this.tapCancel.bind(this)}>
        <Text style={styles.sendButtonText}>Cancel</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.sendButton} onPress={this.tapSend.bind(this)}>
        <Text style={styles.sendButtonText}>Send</Text>
        </TouchableOpacity>
        </View>
      </View>
    );
  }
}

const commonLeftMargin = 35;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'flex-start',
    //alignItems: 'center',
    backgroundColor: 'blue',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    marginTop: 50,
    color:'white'
  },
  instructions: {
    textAlign: 'left',
    color: 'white',
    marginTop: 15,
    marginBottom: 5,
    marginLeft:35,
    marginRight:35,
  },
  subTitle: {
    textAlign: 'left',
    fontSize:15,
    color: 'white',
    marginTop:15,
    marginLeft:35
  },
  subTitleWallet: {
    textAlign: 'left',
    fontSize:15,
    color: 'black',
    marginTop:10,
    marginLeft:35
  },
  pinCodeTitleConfirm: {
    textAlign: 'left',
    fontSize:15,
    color: 'white',
    marginTop:10,
    marginLeft:35
  },
  textInput: {
    fontSize:15,
    backgroundColor:'white',
    marginLeft:35,
    marginRight:35,
    marginTop:10,
    height:30,
    borderRadius:5
  },
  seedGenerateButton: {
    // backgroundColor:'green',
    marginLeft:35,
    marginRight:35,
    marginTop:10,
  },
  seedGenerateButtonText: {
    color:'white',
    // marginRight:35,
    textAlign:'right',
    // backgroundColor:'red'
  },
  sendButton:{
    marginTop:50,
    marginLeft:10,
    marginRight:10,
    height:30,
    width:120,
    backgroundColor:'black',
    alignItems:'center',
    borderRadius:15
  },
  cancelButton:{
    marginTop:50,
    marginLeft:10,
    marginRight:10,
    height:30,
    width:120,
    backgroundColor:'grey',
    alignItems:'center',
    borderRadius:15
  },
  sendButtonText:{
    textAlign:'center',
    fontSize:18,
    color:'white',
    marginTop:3.5
  },
  cancelButtonText:{
    textAlign:'center',
    fontSize:18,
    color:'black',
    marginTop:3.5
  }

});
