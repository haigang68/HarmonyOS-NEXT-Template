import logger from '../utils/logger';
import { BackupExtensionAbility, BundleVersion } from '@kit.CoreFileKit';

export default class EntryBackupAbility extends BackupExtensionAbility {
  async onBackup() {
    logger.info('onBackup ok...');
  }

  async onRestore(bundleVersion: BundleVersion) {
    logger.info('onRestore ok...', JSON.stringify(bundleVersion));
  }
}