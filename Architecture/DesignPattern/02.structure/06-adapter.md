# Adapter（アダプタ）パターン

アダプタ（Adapter）パターンは、インターフェースの互換性のないクラス同士を結合させるためのデザインパターンです。このパターンは、一方のクラスのインターフェースを他方のクラスが期待するインターフェースに変換するアダプターを提供し、異なるクラス間での協力が可能になります。

## 適用場面

- 既存のクラスのインターフェースが他のクラスと互換性がないが、その機能が必要な場合：
  - 特に古いシステムやライブラリを新しいシステムと統合する際に役立ちます。
- 異なるシステムを統合したいが、それらが異なるインターフェースを持つ場合：
  - 外部システムやコンポーネントを使用する際に、外部APIのインターフェースが既存のシステムのインターフェースと異なる場合に適用します。
- 既存のクラスを修正せずに新しいシステムに統合したい場合：
  - アダプタを使用することで、既存のコードを変更することなく新しい要件を満たすことができます。

## メリット

- 再利用性の向上：
  - 既存のクラスやコンポーネントを変更することなく、新しい環境やシステムで再利用することができます。
- コードの結合度の低減：
  - アダプタを介することで、システムの主要部分と外部コンポーネント間の直接的な依存関係を排除し、低結合を実現します。
- 柔軟性と拡張性の向上：
  - 新しいクラスやコンポーネントをシステムに導入する際に、アダプタを使用して既存のインターフェースに合わせることができます。

## デメリット

- 設計の複雑さの増加：
  - アダプターを設計し管理する必要があり、システム全体の複雑さが増します。
- パフォーマンスの低下：
  - アダプターがインターフェース間で追加の処理を行うため、時にはパフォーマンスに影響を与えることがあります。
- 過剰な使用による問題：
  - すべてのインターフェースの問題をアダプタで解決しようとすると、コードが読みにくく、管理が難しくなる可能性があります。

アダプタパターンは、特にレガシーシステムと新システムとの間の橋渡しをする場面で有効ですが、その使用は適切な場面とバランスを考えて行うべきです。

## サンプルコード

```java
// 既存のインターフェース
interface MediaPlayer {
    void play(String audioType, String fileName);
}

// 拡張された機能を持つインターフェース
interface AdvancedMediaPlayer {
    void playVideo(String fileName);
    void playAudio(String fileName);
}

// 拡張メディアプレーヤーの実装
class VlcPlayer implements AdvancedMediaPlayer {
    public void playVideo(String fileName) {
        System.out.println("Playing vlc video file. Name: " + fileName);
    }

    public void playAudio(String fileName) {
        System.out.println("Playing vlc audio file. Name: " + fileName);
    }
}

// アダプタクラス
class MediaAdapter implements MediaPlayer {
    AdvancedMediaPlayer advancedMusicPlayer;

    public MediaAdapter(String audioType) {
        if(audioType.equalsIgnoreCase("vlc")) {
            advancedMusicPlayer = new VlcPlayer();
        }
    }

    public void play(String audioType, String fileName) {
        if(audioType.equalsIgnoreCase("vlc")) {
            advancedMusicPlayer.playVideo(fileName);
        } else {
            advancedMusicPlayer.playAudio(fileName);
        }
    }
}

// クライアントクラス
class AudioPlayer implements MediaPlayer {
    MediaAdapter mediaAdapter;

    public void play(String audioType, String fileName) {
        if(audioType.equalsIgnoreCase("vlc")) {
            mediaAdapter = new MediaAdapter(audioType);
            mediaAdapter.play(audioType, fileName);
        } else {
            System.out.println("Invalid media. " + audioType + " format not supported");
        }
    }
}

// 実行クラス
public class AdapterPatternDemo {
    public static void main(String[] args) {
        AudioPlayer audioPlayer = new AudioPlayer();
        audioPlayer.play("vlc", "beyond_the_horizon.vlc");
    }
}
```

```typescript
// 既存のインターフェース
interface MediaPlayer {
    play(audioType: string, fileName: string): void;
}

// 拡張された機能を持つインターフェース
interface AdvancedMediaPlayer {
    playVideo(fileName: string): void;
    playAudio(fileName: string): void;
}

// 拡張メディアプレーヤーの実装
class VlcPlayer implements AdvancedMediaPlayer {
    playVideo(fileName: string): void {
        console.log("Playing vlc video file. Name: " + fileName);
    }

    playAudio(fileName: string): void {
        console.log("Playing vlc audio file. Name: " + fileName);
    }
}

// アダプタクラス
class MediaAdapter implements MediaPlayer {
    private advancedMusicPlayer: AdvancedMediaPlayer;

    constructor(audioType: string) {
        if (audioType === "vlc") {
            this.advancedMusicPlayer = new VlcPlayer();
        }
    }

    play(audioType: string, fileName: string): void {
        if (audioType === "vlc") {
            this.advancedMusicPlayer.playVideo(fileName);
        } else {
            this.advancedMusicPlayer.playAudio(fileName);
        }
    }
}

// クライアントクラス
class AudioPlayer implements MediaPlayer {
    private mediaAdapter: MediaAdapter;

    play(audioType: string, fileName: string): void {
        if (audioType === "vlc") {
            this.mediaAdapter = new MediaAdapter(audioType);
            this.mediaAdapter.play(audioType, fileName);
        } else {
            console.log("Invalid media. " + audioType + " format not supported");
        }
    }
}

// 実行
let audioPlayer = new AudioPlayer();
audioPlayer.play("vlc", "beyond_the_horizon.vlc");
```