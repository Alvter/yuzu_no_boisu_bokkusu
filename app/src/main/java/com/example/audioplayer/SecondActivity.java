package com.example.audioplayer;

import android.media.MediaPlayer;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.content.Intent;
import android.widget.Spinner;
import android.widget.ArrayAdapter;


import androidx.appcompat.app.AppCompatActivity;

public class SecondActivity extends AppCompatActivity {

    private Button option1Button;
    private Button option3Button;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);  // 设置第二个界面的布局

        option1Button = findViewById(R.id.option1);
        option3Button = findViewById(R.id.option3);

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


        // 创建一个数组，表示可选的值（0到13）
        Integer[] options = new Integer[14];
        for (int i = 0; i <= 13; i++) {
            options[i] = i;
        }


//        // 创建一个数组，表示可选的值（0到13）
//        Integer[] options = new Integer[14];
//        for (int i = 0; i <= 13; i++) {
//            options[i] = i;
//        }
//
//        // 使用 ArrayAdapter 来为 Spinner 提供选项
//        ArrayAdapter<Integer> adapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, options);
//        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
//
//        // 设置适配器
//        spinner.setAdapter(adapter);
    }
}
