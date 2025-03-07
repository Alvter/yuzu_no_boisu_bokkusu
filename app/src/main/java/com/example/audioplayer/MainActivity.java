package com.example.audioplayer;

import android.media.MediaPlayer;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.content.Intent;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    // 变量
    boolean isPlay = false;

    String characterName = "you";

    private MediaPlayer mediaPlayer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 场景按钮
        Button option2Button = findViewById(R.id.option2);
        Button option3Button = findViewById(R.id.option3);

        // 切换场景
        option2Button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // 创建 Intent 跳转到 SecondActivity
                Intent intent = new Intent(MainActivity.this, SecondActivity.class);
                startActivity(intent);  // 启动 SecondActivity
            }
        });

        option3Button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // 创建 Intent 跳转到 SecondActivity
                Intent intent = new Intent(MainActivity.this, ThirdActivity.class);
                startActivity(intent);  // 启动 SecondActivity
            }
        });

        // 获取按钮和 CheckBox
        Button lizhiButton = findViewById(R.id.lizhiButton);
        Button wlizhiButton = findViewById(R.id.wlizhiButton);
        Button chiButton = findViewById(R.id.chiButton);
        Button pongButton = findViewById(R.id.pongButton);
        Button kangButton = findViewById(R.id.kangButton);
        Button bbeiButton = findViewById(R.id.bbeiButton);
        Button rongButton = findViewById(R.id.rongButton);
        Button zimoButton = findViewById(R.id.zimoButton);

        // 按钮点击事件
        loadButtonListener(lizhiButton, "lizhi");
        loadButtonListener(wlizhiButton, "wlizhi");
        loadButtonListener(chiButton, "chi");
        loadButtonListener(pongButton, "pong");
        loadButtonListener(kangButton, "kang");
        loadButtonListener(bbeiButton, "bbei");
        loadButtonListener(rongButton, "rong");
        loadButtonListener(zimoButton, "zimo");

    }

    private void loadButtonListener(Button button,String str) {
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (mediaPlayer != null) {
                    if (mediaPlayer.isPlaying()) {
                        mediaPlayer.stop();
                        mediaPlayer.reset();
                    }
                }
                mediaPlayer = loadVoice(str);

                if (mediaPlayer != null) {
                    mediaPlayer.start();
                }
            }
        });
    }

    // 加载音频
    private MediaPlayer loadVoice(String voiceName) {
        MediaPlayer mediaPlayer = null;
        try {
            int resId = getResources().getIdentifier(characterName + "_" + voiceName, "raw", getPackageName());
            mediaPlayer = MediaPlayer.create(this, resId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mediaPlayer;
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }
}
