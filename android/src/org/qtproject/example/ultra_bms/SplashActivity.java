package org.qtproject.example.ultra_bms;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.Window;
import android.view.WindowManager;

public class SplashActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
		// 确保savedInstanceState不为null
        if (savedInstanceState == null) {
            savedInstanceState = new Bundle();
        }
        
        // 确保Intent的extras不为null
        if (getIntent().getExtras() == null) {
            Bundle extras = new Bundle();
            extras.putString("android.app.lib_name", "ultra_bms");
            extras.putString("android.app.arguments", "");
            extras.putString("android.app.extract_android_style", "minimal");
            getIntent().putExtras(extras);
        }
        super.onCreate(savedInstanceState);
        
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(
            WindowManager.LayoutParams.FLAG_FULLSCREEN,
            WindowManager.LayoutParams.FLAG_FULLSCREEN
        );
        
        new Handler().postDelayed(() -> {
            Intent intent = new Intent(SplashActivity.this, org.qtproject.qt.android.bindings.QtActivity.class);
            
            // 传递Qt Activity需要的所有参数
            Bundle extras = new Bundle();
            
            // 从manifest中获取的关键参数
            extras.putString("android.app.lib_name", "ultra_bms");
            extras.putString("android.app.arguments", "");
            extras.putString("android.app.extract_android_style", "minimal");
            
            // 传递原始Intent的extras（如果有的话）
            if (getIntent().getExtras() != null) {
                extras.putAll(getIntent().getExtras());
            }
            
            intent.putExtras(extras);
            startActivity(intent);
            finish();
        }, 1500);
    }
}