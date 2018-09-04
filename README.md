# AVFoundation
AV日常

#TTS(Text To Speech 文本转语音缩写)

##简介
涉及到AVFoundatio框架中的AVSpeechSynthesizer、AVSpeechUtterance、AVSpeechSynthesisVoice三个类，这三个类的声明都在AVSpeechSynthesis.h里，这三个类比较简单。

需要用到的一些枚举与宏

* 播放暂停时是立即停止播放语音还是播放完当前词再暂停。

	```
	typedef NS_ENUM(NSInteger, AVSpeechBoundary) {
    	AVSpeechBoundaryImmediate,
    	AVSpeechBoundaryWord
	}
	```
	
* 语音质量

	```
	typedef NS_ENUM(NSInteger, AVSpeechSynthesisVoiceQuality) {
    	AVSpeechSynthesisVoiceQualityDefault = 1,
    	AVSpeechSynthesisVoiceQualityEnhanced
	}
	```
	
* 速率	

	```
	AVF_EXPORT const float AVSpeechUtteranceMinimumSpeechRate NS_AVAILABLE_IOS(7_0);
	AVF_EXPORT const float AVSpeechUtteranceMaximumSpeechRate NS_AVAILABLE_IOS(7_0);
	AVF_EXPORT const float AVSpeechUtteranceDefaultSpeechRate NS_AVAILABLE_IOS(7_0);
	```
* 注意：设置属性字符串时，AVSpeechSynthesisIPANotationAttribute的正确使用
	
	```
	AVF_EXPORT NSString *const AVSpeechSynthesisVoiceIdentifierAlex;
	AVF_EXPORT NSString *const AVSpeechSynthesisIPANotationAttribute;
	```
	
##AVSpeechUtterance

要开始说话，请指定AVSpeechSynthesisVoice和要说出的字符串，然后根据需要随意更改速率，音高或音量。

四种初始化方法

```
+ (instancetype)speechUtteranceWithString:(NSString *)string;
+ (instancetype)speechUtteranceWithAttributedString:(NSAttributedString *)string API_AVAILABLE(ios(10.0), watchos(3.0), tvos(10.0));

- (instancetype)initWithString:(NSString *)string;
- (instancetype)initWithAttributedString:(NSAttributedString *)string API_AVAILABLE(ios(10.0), watchos(3.0), tvos(10.0));
```

通过以上创建出来的实例，其语音、语速、音调、音量都是默认的，可以通过属性进行定制，但是在入队后设置这些值将不起作用。其中rate的值应该介于AVSpeechUtteranceMinimumSpeechRate和AVSpeechUtteranceMaximumSpeechRate之间

```
@property(nonatomic, retain, nullable) AVSpeechSynthesisVoice *voice;
@property(nonatomic) float rate;           
@property(nonatomic) float pitchMultiplier;  // [0.5 - 2] Default = 1
@property(nonatomic) float volume;           // [0-1] Default = 1
@property(nonatomic) NSTimeInterval preUtteranceDelay;    // Default is 0.0
@property(nonatomic) NSTimeInterval postUtteranceDelay;   // Default is 0.0
```

有两个属性可以获得当前播放的字符串或属性字符串

```
@property(nonatomic, readonly) NSString *speechString;
@property(nonatomic, readonly) NSAttributedString *attributedSpeechString
```

##AVSpeechSynthesisVoice

通过指定应该在其中说出文本的语言代码来检索语音，或者通过使用voiceWithIdentifier来获取已知语音标识符。

现支持的语音语言37种,可以用类方法speechVoices获取

```
+ (NSArray<AVSpeechSynthesisVoice *> *)speechVoices;
```

language | name | quality | identifier 
------ | ------ | ------ |------ 
ar-SA | Maged | Default | com.apple.ttsbundle.Maged-compact
cs-CZ | Zuzana | 同上 | com.apple.ttsbundle.Zuzana-compact
ar-SA | Maged | 同上 | com.apple.ttsbundle.Maged-compact
cs-CZ | Zuzana | 同上 | com.apple.ttsbundle.Zuzana-compact
da-DK | Sara | 同上 | com.apple.ttsbundle.Sara-compact
de-DE | Anna | 同上 | com.apple.ttsbundle.Anna-compact
el-GR | Melina | 同上 | com.apple.ttsbundle.Melina-compact
en-AU | Karen | 同上 | com.apple.ttsbundle.Karen-compact
en-GB | Daniel | 同上 | com.apple.ttsbundle.Daniel-compact
en-IE | Moira | 同上 | com.apple.ttsbundle.Moira-compact
en-US | Samantha | 同上 | com.apple.ttsbundle.Samantha-compact
en-ZA | Tessa | 同上 | com.apple.ttsbundle.Tessa-compact
es-ES | Monica | 同上 | com.apple.ttsbundle.Monica-compact
es-MX | Paulina | 同上 | com.apple.ttsbundle.Paulina-compact
fi-FI | Satu | 同上 | com.apple.ttsbundle.Satu-compact
fr-CA | Amelie | 同上 | com.apple.ttsbundle.Amelie-compact
fr-FR | Thomas | 同上 | com.apple.ttsbundle.Thomas-compact
he-IL | Carmit | 同上 | com.apple.ttsbundle.Carmit-compact
hi-IN | Lekha | 同上 | com.apple.ttsbundle.Lekha-compact
hu-HU | Mariska | 同上 | com.apple.ttsbundle.Mariska-compact
id-ID | Damayanti | 同上 | com.apple.ttsbundle.Damayanti-compact
it-IT | Alice | 同上 | com.apple.ttsbundle.Alice-compact
ja-JP | Kyoko | 同上 | com.apple.ttsbundle.Kyoko-compact
ko-KR | Yuna | 同上 | com.apple.ttsbundle.Yuna-compact
nl-BE | Ellen | 同上 | com.apple.ttsbundle.Ellen-compact
nl-NL | Xander | 同上 | com.apple.ttsbundle.Xander-compact
no-NO | Nora | 同上 | com.apple.ttsbundle.Nora-compact
pl-PL | Zosia | 同上 | com.apple.ttsbundle.Zosia-compact
pt-BR | Luciana | 同上 | com.apple.ttsbundle.Luciana-compact
pt-PT | Joana | 同上 | com.apple.ttsbundle.Joana-compact
ro-RO | Ioana | 同上 | com.apple.ttsbundle.Ioana-compact
ru-RU | Milena | 同上 | com.apple.ttsbundle.Milena-compact
sk-SK | Laura | 同上 | com.apple.ttsbundle.Laura-compact
sv-SE | Alva | 同上 | com.apple.ttsbundle.Alva-compact
th-TH | Kanya | 同上 | com.apple.ttsbundle.Kanya-compact
tr-TR | Yelda | 同上 | com.apple.ttsbundle.Yelda-compact
zh-CN | Ting-Ting | 同上 | com.apple.ttsbundle.Ting-Ting-compact
zh-HK | Sin-Ji | 同上 | com.apple.ttsbundle.Sin-Ji-compact
zh-TW | Mei-Jia | 同上 | com.apple.ttsbundle.Mei-Jia-compact

获取设备当前语言语音码

```
+ (NSString *)currentLanguageCode;
```

根据指定的语言语音码获取语音

```
+ (nullable AVSpeechSynthesisVoice *)voiceWithLanguage:(nullable NSString *)languageCode;
```

根据指定的语言语音标识码获取语音 iOS9.0之后可用

```
+ (nullable AVSpeechSynthesisVoice *)voiceWithIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(9_0);
```

获取某个语音的信息，只读

```
@property(nonatomic, readonly) NSString *language;
@property(nonatomic, readonly) NSString *identifier NS_AVAILABLE_IOS(9_0);
@property(nonatomic, readonly) NSString *name NS_AVAILABLE_IOS(9_0);
@property(nonatomic, readonly) AVSpeechSynthesisVoiceQuality quality NS_AVAILABLE_IOS(9_0);
```

##AVSpeechSynthesizer
合成器

是否正在播放、暂停

```
@property(nonatomic, readonly, getter=isSpeaking) BOOL speaking;
@property(nonatomic, readonly, getter=isPaused) BOOL paused;
```

将已加入或正在讲话的相同AVSpeechUtterance加入会引发异常。

```
- (void)speakUtterance:(AVSpeechUtterance *)utterance;
```

以下方法只对正在讲话的语音进行操作才有效。 如果成功则返回YES，失败则返回NO。

```
- (BOOL)stopSpeakingAtBoundary:(AVSpeechBoundary)boundary;
- (BOOL)pauseSpeakingAtBoundary:(AVSpeechBoundary)boundary;
- (BOOL)continueSpeaking;
```

指定要用于合成语音的音频通道，如AVAudioSession当前路径中的通道描述所述。
语音音频将复制到每个指定的频道。默认值为nil，表示系统默认值。

```
@property(nonatomic, retain, nullable) NSArray<AVAudioSessionChannelDescription *> *outputChannels;

```