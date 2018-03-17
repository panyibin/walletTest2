import { AppRegistry } from 'react-native';

import WalletGenerator from './js/WalletGenerator';
import PinView from './js/pin';
import Wallet from './js/Wallet';

AppRegistry.registerComponent('WalletGenerator', () => WalletGenerator);
AppRegistry.registerComponent('PinView', () => PinView);
AppRegistry.registerComponent('Wallet', () => Wallet);
