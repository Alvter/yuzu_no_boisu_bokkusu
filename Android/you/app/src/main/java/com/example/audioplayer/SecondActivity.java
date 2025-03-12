package com.example.audioplayer;

import com.example.audioplayer.R;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.content.Intent;
import java.util.ArrayList;
import java.util.List;


import androidx.appcompat.app.AppCompatActivity;

public class SecondActivity extends AppCompatActivity {

    private Button option1Button;
    private Button option3Button;

    // 存储 MediaPlayer 和对应的 CheckBox ID
    private List<MediaPlayer> mediaPlayers = new ArrayList<>();
    private List<CheckBox> checkBoxes = new ArrayList<>();

    // 语音按钮
    private Button playButton;
    private Button stopButton;

    // 变量
    boolean isPlay = false;

    String characterName = "you";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);  // 设置第二个界面的布局

        option1Button = findViewById(R.id.option1);
        option3Button = findViewById(R.id.option3);

        // 获取按钮和 CheckBox
        playButton = findViewById(R.id.play2Button);
        stopButton = findViewById(R.id.stop2Button);

        loadAllChecked();
        loadAllVoice();

        // 设置点击事件
        option1Button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(SecondActivity.this, MainActivity.class);
                startActivity(intent);  // 启动 SecondActivity
            }
        });

        option3Button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(SecondActivity.this, ThirdActivity.class);
                startActivity(intent);  // 启动 SecondActivity
            }
        });

        // 按钮点击事件
        playButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // 遍历所有 CheckBox，根据勾选状态来播放对应的音频
                List<MediaPlayer> selectedPlayers = new ArrayList<>();
                for (int i = 0; i < checkBoxes.size(); i++) {
                    if (checkBoxes.get(i).isChecked()) {
                        selectedPlayers.add(mediaPlayers.get(i));
                    }
                }

                // 按顺序播放选中的音频
                isPlay = true;
                playSelectedAudio(selectedPlayers);
            }
        });

        stopButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                isPlay = false;
            }
        });
    }

    // 定义一个函数，传入控件的ID，返回勾选状态
    public boolean getCheckedStatus(int checkBoxId) {
        CheckBox checkBox = findViewById(checkBoxId); // 根据ID获取CheckBox
        return checkBox.isChecked(); // 返回勾选状态，true表示选中，false表示未选中
    }

    // 加载Checked
    private void loadAllChecked() {
        checkBoxes.add(findViewById(R.id.lizhi));
        checkBoxes.add(findViewById(R.id.wlizhi));
        checkBoxes.add(findViewById(R.id.yifa));
        checkBoxes.add(findViewById(R.id.qianggang));
        checkBoxes.add(findViewById(R.id.lingshang));
        checkBoxes.add(findViewById(R.id.haidi));
        checkBoxes.add(findViewById(R.id.hedi));
        checkBoxes.add(findViewById(R.id.zimo2));
        checkBoxes.add(findViewById(R.id.pinghe));
        checkBoxes.add(findViewById(R.id.yibeikou));
        checkBoxes.add(findViewById(R.id.erbeikou));
        checkBoxes.add(findViewById(R.id.qidui));
        checkBoxes.add(findViewById(R.id.bai));
        checkBoxes.add(findViewById(R.id.fa));
        checkBoxes.add(findViewById(R.id.zhong));
        checkBoxes.add(findViewById(R.id.dong));
        checkBoxes.add(findViewById(R.id.nan));
        checkBoxes.add(findViewById(R.id.xi));
        checkBoxes.add(findViewById(R.id.bei));
        checkBoxes.add(findViewById(R.id.wdong));
        checkBoxes.add(findViewById(R.id.wnan));
        checkBoxes.add(findViewById(R.id.wxi));
        checkBoxes.add(findViewById(R.id.wbei));
        checkBoxes.add(findViewById(R.id.duanyao));
        checkBoxes.add(findViewById(R.id.hunquan));
        checkBoxes.add(findViewById(R.id.yiqi));
        checkBoxes.add(findViewById(R.id.sanshun));
        checkBoxes.add(findViewById(R.id.sanke));
        checkBoxes.add(findViewById(R.id.sangangzi));
        checkBoxes.add(findViewById(R.id.duidui));
        checkBoxes.add(findViewById(R.id.sananke));
        checkBoxes.add(findViewById(R.id.ssanyuan));
        checkBoxes.add(findViewById(R.id.hunlaotou));
        checkBoxes.add(findViewById(R.id.chunquan));
        checkBoxes.add(findViewById(R.id.hun));
        checkBoxes.add(findViewById(R.id.qing));
    }

    // 加载音频
    private void loadAllVoice() {
        loadVoice("lizhi");
        loadVoice("wlizhi");
        loadVoice("yifa");
        loadVoice("qianggang");
        loadVoice("lingshang");
        loadVoice("haidi");
        loadVoice("hedi");
        loadVoice("zimo2");
        loadVoice("pinghe");
        loadVoice("yibeikou");
        loadVoice("erbeikou");
        loadVoice("qidui");
        loadVoice("bai");
        loadVoice("fa");
        loadVoice("zhong");
        loadVoice("dong");
        loadVoice("nan");
        loadVoice("xi");
        loadVoice("bei");
        loadVoice("wdong");
        loadVoice("wnan");
        loadVoice("wxi");
        loadVoice("wbei");
        loadVoice("duanyao");
        loadVoice("hunquan");
        loadVoice("yiqi");
        loadVoice("sanshun");
        loadVoice("sanke");
        loadVoice("sangangzi");
        loadVoice("duidui");
        loadVoice("sananke");
        loadVoice("ssanyuan");
        loadVoice("hunlaotou");
        loadVoice("chunquan");
        loadVoice("hun");
        loadVoice("qing");
    }
    private void loadVoice(String voiceName){
        int resId = getResources().getIdentifier(characterName + "_" + voiceName, "raw", getPackageName());
        mediaPlayers.add(MediaPlayer.create(this, resId));
    }

    private void playSelectedAudio(List<MediaPlayer> selectedPlayers) {
        if (selectedPlayers.isEmpty()) {
            return;
        }

        // 播放第一个音频
        MediaPlayer currentPlayer = selectedPlayers.get(0);
        currentPlayer.start();

        // 设置完成监听器，播放下一个音频
        currentPlayer.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
            int currentIndex = 1;

            @Override
            public void onCompletion(MediaPlayer mp) {
                if (isPlay && currentIndex < selectedPlayers.size()) {
                    MediaPlayer nextPlayer = selectedPlayers.get(currentIndex);
                    nextPlayer.start();
                    currentIndex++;
                    nextPlayer.setOnCompletionListener(this);  // 设置监听器以播放下一个音频
                }
            }
        });
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        // 释放所有 MediaPlayer 资源
        for (MediaPlayer mediaPlayer : mediaPlayers) {
            if (mediaPlayer != null) {
                mediaPlayer.release();
            }
        }
    }
}
