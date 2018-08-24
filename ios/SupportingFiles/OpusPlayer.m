//
//  OpusPlayer.m
//  SymbolScanClient
//
//  Created by Morgan Wilde on 7/27/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "OpusPlayer.h"

#import "OpusHelper.h"

long SAMPLE_RATE = 48000;
AVAudioPlayer *player;

@implementation OpusPlayer

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(playFromData:(NSString *)data) {
  NSData *oggAudioData = [[NSData alloc] initWithBase64EncodedString:data
                                                             options:NSDataBase64DecodingIgnoreUnknownCharacters
                          ];
  
  OpusHelper *opusHelper = [[OpusHelper alloc] init];
  NSData *audioData = [opusHelper opusToPCM:oggAudioData sampleRate:SAMPLE_RATE];
  audioData = [OpusPlayer addWavHeader:audioData];
  
  NSError *error;
  player = [[AVAudioPlayer alloc] initWithData:audioData
                                  fileTypeHint:AVFileTypeWAVE
                                         error:&error];
  [player play];
}

+ (NSMutableData *)addWavHeader:(NSData *)wavNoheader {
  
  int headerSize = 44;
  long totalAudioLen = [wavNoheader length];
  long totalDataLen = [wavNoheader length] + headerSize-8;
  long longSampleRate = SAMPLE_RATE;
  int channels = 1;
  long byteRate = 16 * 11025 * channels/8;
  
  Byte *header = (Byte*)malloc(44);
  header[0] = 'R';  // RIFF/WAVE header
  header[1] = 'I';
  header[2] = 'F';
  header[3] = 'F';
  header[4] = (Byte) (totalDataLen & 0xff);
  header[5] = (Byte) ((totalDataLen >> 8) & 0xff);
  header[6] = (Byte) ((totalDataLen >> 16) & 0xff);
  header[7] = (Byte) ((totalDataLen >> 24) & 0xff);
  header[8] = 'W';
  header[9] = 'A';
  header[10] = 'V';
  header[11] = 'E';
  header[12] = 'f';  // 'fmt ' chunk
  header[13] = 'm';
  header[14] = 't';
  header[15] = ' ';
  header[16] = 16;  // 4 bytes: size of 'fmt ' chunk
  header[17] = 0;
  header[18] = 0;
  header[19] = 0;
  header[20] = 1;  // format = 1
  header[21] = 0;
  header[22] = (Byte) channels;
  header[23] = 0;
  header[24] = (Byte) (longSampleRate & 0xff);
  header[25] = (Byte) ((longSampleRate >> 8) & 0xff);
  header[26] = (Byte) ((longSampleRate >> 16) & 0xff);
  header[27] = (Byte) ((longSampleRate >> 24) & 0xff);
  header[28] = (Byte) (byteRate & 0xff);
  header[29] = (Byte) ((byteRate >> 8) & 0xff);
  header[30] = (Byte) ((byteRate >> 16) & 0xff);
  header[31] = (Byte) ((byteRate >> 24) & 0xff);
  header[32] = (Byte) (2 * 8 / 8);  // block align
  header[33] = 0;
  header[34] = 16;  // bits per sample
  header[35] = 0;
  header[36] = 'd';
  header[37] = 'a';
  header[38] = 't';
  header[39] = 'a';
  header[40] = (Byte) (totalAudioLen & 0xff);
  header[41] = (Byte) ((totalAudioLen >> 8) & 0xff);
  header[42] = (Byte) ((totalAudioLen >> 16) & 0xff);
  header[43] = (Byte) ((totalAudioLen >> 24) & 0xff);
  
  NSMutableData *newWavData = [NSMutableData dataWithBytes:header length:44];
  [newWavData appendBytes:[wavNoheader bytes] length:[wavNoheader length]];
  free(header);
  return newWavData;
}

@end
