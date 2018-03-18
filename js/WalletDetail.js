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
  TouchableHighlight,
  FlatList,
  ScrollView,
  Clipboard
} from 'react-native';

var walletManager = NativeModules.WalletManager;
var navigationHelper = NativeModules.NavigationHelper;
// var {Clipboard} = ReactNative;

type Props = {};
export default class WalletDetail extends Component<Props> {

  constructor(props){
    super(props);
    this.state = {pinCode:"", pinCodeConfirm:""};
    // Alert.alert(props.data);
  }

async tapNewAddress() {
    // Alert.alert('new address');
    // walletManager.createNewAddressWithWalletId(this.props.walletModelDict.walletId, 1);
    Alert.alert(
        'A new address will be created in this wallet.',
        '',
        [
            {text:'OK', onPress:()=>{
                walletManager.createNewAddressWithWalletId(this.props.walletModelDict.walletId, 1);
            }},
            {text:'Cancel', onPress:()=>{

            }, style:'cancel'}            
        ]
    );
  }

  async tapSendSky() {
      //Alert.alert('send sky');
      navigationHelper.showPayCoinViewControllerWithWalletModelDict(this.props.walletModelDict, true);
  }

  longPressWalletTitle() {
    Clipboard.setString(this.props.walletModelDict.seed);
    Alert.alert('seed copied',this.props.walletModelDict.seed);
  }

  render() {
    return (
        <View style={styles.container}>
        <View style={styles.topView}>
        <TouchableOpacity onLongPress={this.longPressWalletTitle.bind(this)} >
        <Text style={styles.pageTitle}>
                {this.props.walletModelDict.walletName}
        </Text>
        </TouchableOpacity>
        </View>
        <ScrollView style={{backgroundColor:'white'}}>
            <View style={{backgroundColor:'#1A9BFC'}}>
                <Text style={styles.skyCoinBalance}>
                    {(this.props.totalCoinBalance != undefined ? this.props.totalCoinBalance : '0')   + ' SKY'}
                </Text>
                <Text style={styles.skyHourBalance}>
                    {(this.props.totalHourBalance != undefined ? this.props.totalHourBalance : '0') + ' Hours'}
                </Text>
            </View>
            <View style={{marginTop:0, backgroundColor:'white'}}>
                <View style={{flexDirection:'row',marginTop:10,marginBottom:10}}>
                 <Text style={{marginLeft:10,width:200, backgroundColor:'transparent',fontSize:15, fontWeight:'bold', color:'#C3C4C6'}}>Address</Text>
                 <Text style={{marginLeft:80,width:100, backgroundColor:'transparent',fontSize:15, fontWeight:'bold', color:'#C3C4C6'}}>Balance</Text>
                </View>
                <View style={{height:0.5, backgroundColor:'#EFF0F0'}} />
                <FlatList
                data={this.props.data}

                renderItem={({item})=>{
                    return (
                        <TouchableOpacity onPress={
                            // Alert.alert('hello');
                            ()=>{
                                Clipboard.setString(item.address);
                                Alert.alert('Address copied',item.address);
                            }
                        }>
                        <View>
                        <View style={{ flexDirection: 'row', marginBottom:10,marginTop:10 }}>
                        <View style={{marginLeft:10,width:200}}>
                        <Text 
                        style={{backgroundColor: 'transparent', fontSize: 15 ,fontWeight:'bold', color:'#919497'}}
                        numberOfLines={1}
                        >
                        {item.address}
                        </Text>
                        </View>
                        <View style={{marginLeft:80, width:100}}>
                        <Text style={{backgroundColor: 'transparent', fontSize: 15, textAlign:'left', fontWeight:'bold'}}>{item.balance}</Text>
                        </View>                                                        
                        </View>
                        <View 
                        style={{height:0.5, backgroundColor:'#EFF0F0'}}
                        />
                        </View>
                        </TouchableOpacity>
                    );
                }}

                keyExtractor = { item => item.address}

                >
                </FlatList>
            </View>
            </ScrollView>
            <View style={{ flexDirection: 'row', justifyContent: 'center',backgroundColor:'white' }}>
                <TouchableOpacity style={styles.newAddressButton} onPress={this.tapSendSky.bind(this)}>
                    <Text style={styles.newAddressButtonText}>Send Sky</Text>
                </TouchableOpacity>
                <TouchableOpacity style={styles.newAddressButton} onPress={this.tapNewAddress.bind(this)}>
                    <Text style={styles.newAddressButtonText}>New Address</Text>
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
    backgroundColor: '#1A9BFC',
  },
  topView: {
    flexDirection:'row',
    justifyContent:'center'
},
  pageTitle: {
    fontSize: 20,
    textAlign: 'center',
    marginTop: 50,
    marginBottom: 10,
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
  skyCoinBalance: {
    textAlign: 'center',
    fontSize:35,
    color: 'white',
    marginTop:50,
  },
  skyHourBalance: {
    textAlign: 'center',
    fontSize:17,
    color: 'white',
    marginTop:20,
    marginBottom:30
  },
  newAddressButton:{
    marginTop:20,
    marginRight:15,
    marginBottom:40,
    height:30,
    width:140,
    backgroundColor:'#EFF0F0',
    alignItems:'center',
    borderRadius:15
  },
  newAddressButtonText:{
    textAlign:'center',
    fontSize:15,
    color:'black',
    marginTop:6,
    fontWeight:'bold'
  }

});
