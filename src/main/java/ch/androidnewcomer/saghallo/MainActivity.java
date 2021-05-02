package ch.androidnewcomer.saghallo;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.speech.tts.TextToSpeech;

public class MainActivity extends AppCompatActivity implements TextToSpeech.OnInitListener {
    private TextToSpeech tts;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        tts = new TextToSpeech(this, this);
    }

    @Override
    public void onInit(int i){
        tts.speak("Guten Tag mein Meister. Wie kann ich Ihnen heute Dienen.", TextToSpeech.QUEUE_FLUSH, null);
    }

}