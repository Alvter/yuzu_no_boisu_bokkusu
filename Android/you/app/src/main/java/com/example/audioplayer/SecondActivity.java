package com.example.audioplayer;

import com.example.audioplayer.R;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.content.Intent;
import android.widget.EditText;

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

                int[] checkBoxIds = {R.id.dora, R.id.rdora, R.id.dora2};
                int[] editTextIds = {R.id.doraEdit, R.id.rdoraEdit, R.id.dora2Edit};

                for (int i = 0; i < checkBoxIds.length; i++) {
                    CheckBox checkBox = findViewById(checkBoxIds[i]);
                    if (checkBox.isChecked()) {
                        addDoraVoice(editTextIds[i], selectedPlayers);
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
        int[] ids = {
                R.id.lizhi, R.id.wlizhi, R.id.yifa, R.id.qianggang, R.id.lingshang, R.id.haidi,
                R.id.hedi, R.id.zimo2, R.id.pinghe, R.id.yibeikou, R.id.erbeikou, R.id.qidui,
                R.id.bai, R.id.fa, R.id.zhong, R.id.dong, R.id.nan, R.id.xi, R.id.bei,
                R.id.wdong, R.id.wnan, R.id.wxi, R.id.wbei, R.id.duanyao, R.id.hunquan,
                R.id.yiqi, R.id.sanshun, R.id.sanke, R.id.sangangzi, R.id.duidui, R.id.sananke,
                R.id.ssanyuan, R.id.hunlaotou, R.id.chunquan, R.id.hun, R.id.qing
        };

        for (int id : ids) {
            checkBoxes.add(findViewById(id));
        }
    }


    // 加载音频
    private void loadAllVoice() {
        String[] voices = {
                "lizhi", "wlizhi", "yifa", "qianggang", "lingshang", "haidi", "hedi",
                "zimo2", "pinghe", "yibeikou", "erbeikou", "qidui", "bai", "fa", "zhong",
                "dong", "nan", "xi", "bei", "wdong", "wnan", "wxi", "wbei", "duanyao",
                "hunquan", "yiqi", "sanshun", "sanke", "sangangzi", "duidui", "sananke",
                "ssanyuan", "hunlaotou", "chunquan", "hun", "qing", "dora", "dora2",
                "dora3", "dora4", "dora5", "dora6", "dora7", "dora8",
        };

        for (String voice : voices) {
            loadVoice(voice);
        }
    }

    private void loadVoice(String voiceName){
        int resId = getResources().getIdentifier(characterName + "_" + voiceName, "raw", getPackageName());
        mediaPlayers.add(MediaPlayer.create(this, resId));
    }

    private void addDoraVoice(int editTextId, List<MediaPlayer> mediaPlayer) {
        EditText editText = findViewById(editTextId);
        String dora = editText.getText().toString();
        int resId = getResources().getIdentifier(characterName + "_dora" + dora, "raw", getPackageName());
        // 打印拼接出来的资源名以便调试
        String resourceName = characterName + "_dora" + dora;
        mediaPlayer.add(MediaPlayer.create(this, resId));
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
