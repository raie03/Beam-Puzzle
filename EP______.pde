import ddf.minim.*;

Minim minim;
AudioPlayer player;
String bgm1;
String bgm2;
String bgm3;
PImage img;
int ix, iy;

//キャラ初期座標
int cx = 900;
int cy = 550;

int cx2 = 300;
int cy2 = 550;

/*int isMove0 = 0;
 int isMove1 = 0;
 int isMove2 = 0;
 int isMove3 = 0;*/
int status = 5;

//ステージの大きさ
int left = 1000;
int right = 1700;
int top = 200;
int bottom = 900;

int left2 = 400;
int top2 = 100;
int bottom2 = 1000;

int sc = 0;
int wc = 0;

//手数
float count = 0;

//シーンID
int scene = 0; //現在のシーン
int go = 0; //進みたいシーン

//フォント
PFont D7;
PFont S;
PFont Font;

//時間
float sec;
float min;
//int h;
int base_time = 0;
//リザルトタイム
float rs = 0;
float rm = 0;

//スコア
float score = 0;

//ロード画面の線の左端ｘ座標
int lx = 400;

//ボタンの移動
int y = 800;
int y2 = 800;

//タイトル画面関数
void start_scene()
{
  player.play();
  if ( player.position() >= 64 * 1000)
  {
    player.rewind();
    player.play();
  }
  blendMode(BLEND);
  background(0);

  blendMode(ADD);
  textFont(D7);
  textAlign(LEFT, CENTER);
  int a = frameCount % 92;
  for (float r = 0.0; r< 1.0; r += 0.1)
  {
    //stroke(200, 100, 100);
    fill(140, 100, (1.0 - r) * 20);
    textSize(150);

    if (a < 23)
    {
      text("BEAM PUZZLE", 375, 200);
    } else if (a < 46)
    {
      text("BEAM PUZZLE .", 375, 200);
    } else if (a < 69)
    {
      text("BEAM PUZZLE .  .", 375, 200);
    } else if (a < 92 )
    {
      text("BEAM PUZZLE .  .  .", 375, 200);
    }
  }

  //スタートボタン
  stroke(255);
  pushMatrix();
  translate(1000, 800);

  beginShape();

  vertex(-150, -50);
  vertex(150, -50);
  vertex(150, 50);
  vertex(-150, 50);

  endShape(CLOSE);
  popMatrix();

  textAlign(CENTER, CENTER);
  textSize(70);
  fill(140, 100, 60);
  if (mouseX > -150 +1000 && mouseX < 150 + 1000 && mouseY > -50 + 800 && mouseY < 50 + 800 && scene == 0)
  {
    fill(140, 100, 100);
    if (mousePressed == true && mouseButton == LEFT)
    {
      scene = 5;
    }
  }
  text("START", 1000, 800);
}

//難易度選択画面
void select()
{
  player.play();
  if ( player.position() >= 64 * 1000)
  {
    player.rewind();
    player.play();
  }
  blendMode(BLEND);
  background(0);

  blendMode(ADD);
  textFont(D7);
  textAlign(LEFT, CENTER);
  int a = frameCount % 100;
  for (float r = 0.0; r< 1.0; r += 0.1)
  {
    //stroke(200, 100, 100);
    fill(140, 100, (1.0 - r) * 20);
    textSize(150);

    if (a < 25)
    {
      text("BEAM PUZZLE", 375, 200);
    } else if (a < 50)
    {
      text("BEAM PUZZLE .", 375, 200);
    } else if (a < 75)
    {
      text("BEAM PUZZLE .  .", 375, 200);
    } else if (a < 100)
    {
      text("BEAM PUZZLE .  .  .", 375, 200);
    }
  }

  //ノーマルボタン
  stroke(255);
  pushMatrix();
  translate(800, 650);
  noFill();
  beginShape();

  vertex(-170, -50);
  vertex(170, -50);
  vertex(170, 50);
  vertex(-170, 50);

  endShape(CLOSE);
  popMatrix();


  textAlign(CENTER, CENTER);
  textSize(70);
  fill(140, 100, 60);
  if (mouseX > -150 +800 && mouseX < 150 + 800 && mouseY > -50 + 650 && mouseY < 50 + 650 && scene == 5)
  {
    fill(140, 100, 100);
    if (mousePressed == true && mouseButton == LEFT)
    {
      scene = 3;
      lx = 400;
      go = 1;
      base_time = millis();
    }
  }
  text("NORMAL", 800, 650);

  //ハードボタン
  stroke(255);
  pushMatrix();
  translate(1200, 650);
  noFill();
  beginShape();

  vertex(-170, -50);
  vertex(170, -50);
  vertex(170, 50);
  vertex(-170, 50);

  endShape(CLOSE);
  popMatrix();


  textAlign(CENTER, CENTER);
  textSize(70);
  fill(140, 100, 60);
  if (mouseX > -150 +1200 && mouseX < 150 + 1200 && mouseY > -50 + 650 && mouseY < 50 + 650 && scene == 5)
  {
    fill(140, 100, 100);
    if (mousePressed == true && mouseButton == LEFT)
    {
      scene = 3;
      lx = 400;
      go = 4;
      base_time = millis();
    }
  }
  text("HARD", 1200, 650);

  //バックボタン
  noFill();
  stroke(255);
  pushMatrix();
  translate(1800, 1050);

  beginShape();

  vertex(-150, -50);
  vertex(150, -50);
  vertex(150, 50);
  vertex(-150, 50);

  endShape(CLOSE);
  popMatrix();

  textAlign(CENTER, CENTER);
  textSize(70);
  fill(140, 100, 60);
  if (mouseX > -150 +1800 && mouseX < 150 + 1800 && mouseY > -50 + 1050 && mouseY < 50 + 1050)
  {
    fill(140, 100, 100);
    if (mousePressed == true && mouseButton == LEFT)
    {
      scene = 0;
    }
  }
  text("back", 1800, 1050);
}



//リザルト画面
void result()
{
  frameRate(30);
  blendMode(BLEND);
  background(0);

  blendMode(ADD);
  textFont(D7);
  textAlign(CENTER, CENTER);
  for (float r = 0.0; r< 1.0; r += 0.1)
  {
    //stroke(200, 100, 100);
    fill(140, 100, (1.0 - r) * 20);
    textSize(150);

    text("RESULT", 1000, 200);
  }
  textAlign(LEFT, CENTER);
  textSize(100);
  fill(140, 100, 80);
  text("COUNT", 500, 500);
  text("TIME", 500, 650);
  text("SCORE", 500, 800);
  text("RANK", 500, 950);
  textAlign(RIGHT, CENTER);
  text((int)count, 1450, 500);//カウント

  if ((int)rs < 10)
  {
    text((int)rm + ":0" + (int)rs, 1450, 650);
  } else if ((int)rs >= 10)
  {
    text((int)rm + ":" + (int)rs, 1450, 650);
  }

  text((int)score, 1450, 800);
  if ((int)score >= 1000)
    text("S", 1450, 950);
  else if ((int)score >= 800)
    text("A", 1450, 950);
  else if ((int)score >= 600)
    text("B", 1450, 950);
  else if ((int)score < 600)
    text("C", 1450, 950);


  //ホームボタン
  noFill();
  stroke(255);
  pushMatrix();
  translate(1800, 1050);

  beginShape();

  vertex(-150, -50);
  vertex(150, -50);
  vertex(150, 50);
  vertex(-150, 50);

  endShape(CLOSE);
  popMatrix();

  textAlign(CENTER, CENTER);
  textSize(70);
  fill(140, 100, 60);
  if (mouseX > -150 +1800 && mouseX < 150 + 1800 && mouseY > -50 + 1050 && mouseY < 50 + 1050)
  {
    fill(140, 100, 100);
    if (mousePressed == true && mouseButton == LEFT)
    {
      scene = 3;
      lx = 400;
      go = 0;
      base_time = millis();
    }
  }
  text("HOME", 1800, 1050);
}

//ロード画面関数
void loading()
{
  player.close();


  frameRate(30);
  blendMode(BLEND);
  background(0);

  blendMode(ADD);
  textFont(D7);
  textAlign(LEFT, CENTER);
  int a = frameCount % 20;
  for (float r = 0.0; r< 1.0; r += 0.1)
  {
    //stroke(200, 100, 100);
    fill(140, 100, (1.0 - r) * 20);
    textSize(100);

    if (a < 5)
    {
      text("now loading", 600, 400);
    } else if (a < 10)
    {
      text("now loading .", 600, 400);
    } else if (a < 15)
    {
      text("now loading .  .", 600, 400);
    } else if (a < 20)
    {
      text("now loading .  .  .", 600, 400);
    }
  }

  //blendMode(BLEND);
  strokeWeight(10);
  stroke(255);
  line(400, 575, 1600, 575);

  stroke(140, 100, 100);
  line(400, 575, lx, 575);
  strokeWeight(1);
  //blendMode(ADD);
  if (lx < 1600)
  {
    lx += 40;
  }
  if (lx >= 1600)
  {
    if (go ==1)
    {
      player = minim.loadFile(bgm2);
      scene = 1;
      base_time = millis();
      for (int i=0; i<49; i++)
      {
        if (m.get(i).d < 5)
        {
          m.get(i).d = 4;
        }
      }
      count = 0;
      sc = 0;
      g.lock();
      g.turnOff();
      b.clear();
      e.life = 1;
    } else if (go ==4)
    {
      player = minim.loadFile(bgm3);
      scene = 4;
      base_time = millis();
      for (int i=0; i<117; i++)
      {
        if (m2.get(i).d < 5)
        {
          m2.get(i).d = 4;
        }
      }
      count = 0;
      sc = 0;
      g.lock();
      g.turnOff();
      b.clear();
      e.life = 1;
    } else if (go == 0)
    {
      player = minim.loadFile(bgm1);
      scene = 0;
    }
  }
}

void stage2()
{
  player.play();
  if ( player.position() >= 64 * 1000)
  {
    player.rewind();
    player.play();
  }
  blendMode(BLEND);
  background(0);

  //ステージの大きさ
  blendMode(ADD);
  stroke(10, 120, 40);


  for (int i=0; i<10; i++)
  {
    strokeWeight(1);
    stroke(140, 100, 50);

    line(left2, top2+i*100, right, top2+i*100);
  }

  for (int i=0; i<14; i++)
  {
    strokeWeight(1);
    stroke(140, 100, 50);
    line(left2+i*100, top2, left2+i*100, bottom2);
  }

  //手数
  fill(140, 100, 100);
  textFont(D7);
  textSize(60);
  textAlign(LEFT, CENTER);
  text("COUNT", 20, 50);
  textAlign(CENTER, CENTER);
  textSize(100);
  text((int)count, 150, 150);
  textSize(20);
  text("START", 300, 490);
  fill(0, 100, 100);
  text("GOAL", 1850, 490);

  //時間
  fill(140, 100, 100);
  textAlign(LEFT, CENTER);
  textSize(60);
  text("TIME", 20, 275);
  textSize(100);

  sec = (millis()-base_time)/1000;
  //min = int(sec/60);
  if (sec < 10)
  {
    text((int)min + ":" + "0" + (int)sec, 110, 375);
  } else if (sec >= 10)
  {
    text((int)min + ":" + (int)sec, 110, 375);
  }
  if (sec >=60)
  {
    base_time = millis();
    min++;
  }

  //プレイヤー
  //fill(255);

  for (float r = 0.0; r< 1.0; r += 0.1)
  {
    noStroke();
    fill(160, 100, (1.0 - r) * 60);
    ellipse(cx2, cy2, 100 * r, 100 * r);
  }


  //敵
  e.display();

  //ゲート
  g.display();

  //矢印表示

  for (int i =0; i < m2.size(); i++)
  {
    m2.get(i).display();
  }

  //ビーム処理
  for (int i = 0; i < b.size(); i++)
  {
    b.get(i).move();
    for (int j = 0; j < m2.size(); j++)
    {

      //方向変換
      if (b.get(i).x2 == m2.get(j).mx && b.get(i).y2 == m2.get(j).my)
      {
        //上
        if (m2.get(j).d == 0)
        {
          b.get(i).x2 = m2.get(j).mx-1;
          b.get(i).vx2 = 0;

          b.add(new Beam(m2.get(j).mx, m2.get(j).my, 10, 0, -10, 0, -10));
        }

        //左
        else if (m2.get(j).d == 1)
        {
          b.get(i).y2 = m2.get(j).my+1;
          b.get(i).vy2 = 0;

          b.add(new Beam(m2.get(j).mx, m2.get(j).my, 10, -10, 0, -10, 0));
        }

        //下
        else if (m2.get(j).d == 2)
        {
          b.get(i).x2 = m2.get(j).mx+1;
          b.get(i).vx2 = 0;

          b.add(new Beam(m2.get(j).mx, m2.get(j).my, 10, 0, 10, 0, 10));
        }

        //右
        else if (m2.get(j).d == 3 && b.get(i).vx2 != 10)
        {
          b.get(i).y2 = m2.get(j).my-1;
          b.get(i).vy2 = 0;

          b.add(new Beam(m2.get(j).mx, m2.get(j).my, 10, 10, 0, 10, 0));
        }

        //壁
        else if (m2.get(j).d == 5)
        {
          //b.get(i).x2 = m.get(j).mx;
          b.get(i).vx2 = 0;
          b.get(i).vy2 = 0;
          //g.lock();
        }

        //スイッチ
        else if (m2.get(j).d == 7)
        {
          for (int k = 0; k<m2.size(); k++)
          {
            if (m2.get(k).d == 5)
              m2.get(k).d = 6;
            else if (m2.get(k).d == 6)
              m2.get(k).d = 5;
          }
          sc++;
        }


        //鍵
        else if (m2.get(j).d == 8)
        {
          g.unlock();
          m2.get(j).d = 9;
        }
      }

      //停止
      if (b.get(i).x == m2.get(j).mx && b.get(i).y == m2.get(j).my)
      {
        if (m2.get(j).d == 0)
          b.get(i).vx = 0;
        else if (m2.get(j).d == 1)
          b.get(i).vy = 0;
        else if (m2.get(j).d == 2)
          b.get(i).vx = 0;
        else if (m2.get(j).d == 3 && b.get(i).vx != 10)
          b.get(i).vy = 0;
        else if (m2.get(j).d == 5 && b.get(i).vx2 == 0 && b.get(i).vy2 == 0)
        {
          b.get(i).vx = 0;
          b.get(i).vy = 0; 
          //g.turnOff();
          wc++;
          reset();
          //重ならないように
          b.get(i).x = m2.get(j).mx + 1;
          b.get(i).y = m2.get(j).my + 1;
        }
      }
    }

    //ゲート障害
    if (b.get(i).x2 == g.gx && b.get(i).y2 == g.gy && g.n > 0)
    {
      //b.get(i).x2 = g.gx;
      b.get(i).vx2 = 0;
      b.get(i).vy2 = 0;
      //g.lock();
      //g.turnOff();
    }
    if (b.get(i).x == g.gx && b.get(i).y == g.gy && g.n > 0)
    {
      b.get(i).vx = 0;
      b.get(i).vy = 0;
    }

    //敵直撃&クリア
    if (b.get(i).x2 == e.ex && b.get(i).y2 == e.ey && e.life > 0)
    {
      b.get(i).vx2 = 0;
      b.get(i).vy2 = 0;
      e.damaged();
    }
    if (b.get(i).x == e.ex && b.get(i).y == e.ey && e.life == 0)
    {
      b.get(i).vx = 0;
      b.get(i).vy = 0;

      //クリア
      e.clear();
    }


    //消去
    if (b.get(i).delete == 2)
    {
      b.remove(i);
      //g.lock();
      //g.turnOff();
      reset();
    }
  }

  //消去
  if (b.size() >=5)
  {
    b.remove(0);
  }
}

//敵クラス
class Enemy
{
  int ex, ey, life;
  Enemy(int ex, int ey, int life)
  {
    this.ex = ex + 50;
    this.ey = ey + 50;
    this.life = life;
  }

  void display()
  {
    noStroke();
    for (float r = 0.0; r< 1.0; r += 0.1)
    {
      fill(0, 100, (1.0 - r) * 100);
      if (life > 0)
        ellipse(ex, ey, 100 * r, 100 * r);
    }
  }

  //ダメージ処理
  void damaged()
  {
    life -= 1;
  }

  //クリア処理
  void clear()
  {
    if (life == 0)
    {
      println("CLEAR!");
      println("記録: " + count + "手");
      rs = sec;
      rm = min;
      score = (14 / count) * 500 + (40 / (sec + 60 * min)) * 500;
      frameRate(1);
      scene = 2;
    }
  }
}

//ゲートクラス
class Gate
{
  int gx, gy, n;
  Gate(int gx, int gy, int n)
  {
    this. gx = gx + 50;
    this. gy = gy + 50;
    this. n = n;
  }

  void display()
  {
    strokeWeight(3);
    stroke(0, 100, 80);
    if (n >= 2)
      line(gx-50, gy-50, gx+50, gy+50);
    if (n >= 1)
      line(gx+50, gy-50, gx-50, gy+50);
  }

  //ゲート解除処理
  void unlock()
  {
    n -= 1;
  }

  //ゲートと鍵戻す
  void lock()
  {
    if (n <2)
    {
      if (scene == 1)
      {
        for (int i=0; i<49; i++)
        {
          if (m.get(i).d == 9)
          {
            m.get(i).d = 8;
            n += 1;
          }
        }
      } else if (scene == 4)
      {
        for (int i=0; i<m2.size(); i++)
        {
          if (m2.get(i).d == 9)
          {
            m2.get(i).d = 8;
            n += 1;
          }
        }
      }
    }
  }

  //スイッチ戻す
  void turnOff()
  {
    if (sc % 2 == 1)
    {
      if (scene == 1)
      {
        for (int i=0; i<49; i++)
        {
          if (m.get(i).d == 5)
            m.get(i).d = 6;
          else if (m.get(i).d == 6)
            m.get(i).d = 5;
        }
      } else if (scene == 4)
      {
        for (int i=0; i<m2.size(); i++)
        {
          if (m2.get(i).d == 5)
            m2.get(i).d = 6;
          else if (m2.get(i).d == 6)
            m2.get(i).d = 5;
        }
      }
      sc = 0;
    }
  }
}

//マス目クラス
ArrayList<Masu>m;
ArrayList<Masu>m2;
class Masu
{
  int mx, my, d, vx, vy, left, top;
  int mw = 100;//幅
  Masu(int mx, int my, int d, int vx, int vy, int left, int top)
  {
    this.left = left;
    this.top = top;
    this.mx = this.left+mx*mw+50;
    this.my = this.top+my*mw+50;
    this.d = d;
    this.vx = vx;
    this.vy = vy;
  }

  //矢印表示
  void display()
  {
    fill(140, 100, 80);
    strokeWeight(3);
    textFont(S);
    textAlign(CENTER, CENTER);
    textSize(100);
    if (d == 0)
    {  
      text("U", mx+15, my-15);//上
    } else if (d == 1)
      text("L", mx+13, my-15);//左
    else if (d == 2)
      text("D", mx+15, my-15);//下
    else if (d == 3)
      text("R", mx+15, my-15);//右
    else if (d == 5)
    {
      stroke(0, 100, 60);
      line(mx-50, my-50, mx+50, my+50);//有効障害物
    } else if (d == 6)
    {
      stroke(200, 100, 60);
      for (int i=1; i<=7; i++)
        line(mx-50+15*(i-1), my-50+15*(i-1), mx-50+15*i-5, my-50+15*i-5);//無効障害物
    } else if (d == 7)
    {
      for (float r = 0.0; r< 1.0; r += 0.1)
      {
        noStroke();
        fill(200, 100, (1.0 - r) * 90);
        if (sc % 2 == 1)
        {
          fill(0, 100, (1.0- r) * 80);
        }
        square(mx-25 + 25*(1-r), my-25 + 25*(1-r), 50 * r);//スイッチ
      }
    } else if (d == 8)
    {
      //fill(255); //鍵
      //noStroke();
      //stroke(240,100,100);
      stroke(200, 100, 60);
      fill(200, 100, 80);

      rect(mx-5, my+13, 24, 10);
      rect(mx-5, my+30, 24, 10);
      rect(mx-5, my-15, 8, 60);
      ellipse(mx, my-25, 33, 33);
      fill(255);
      ellipse(mx, my-25, 20, 20);
    }
  }

  void move()
  {
    mx += vx;
    my += vy;
  }
}


//ビームクラス
ArrayList<Beam>b;
class Beam {
  float x, y, l, vx, vy, vx2, vy2;
  Beam(float x, float y, int l, int vx, int vy, int vx2, int vy2) {
    this.x = x;
    this.y = y;
    this.l = l;
    this.vx = vx;
    this.vy = vy;
    this.vx2 = vx2;
    this.vy2 = vy2;
    x2 = x;
    y2 = y;
  }
  float x2, y2;
  int second = 0;
  int delete = 0;
  void move()
  {
    strokeWeight(1);
    //stroke(0);

    stroke(140, 100, 100);
    line(x, y, x2, y2);

    second++;
    if (second > l)
    {
      x += vx;
      y += vy;
    }
    x2 += vx2;
    y2 += vy2;


    if (x > width || x< 0 || y > height || y < 0)
      delete = 1;
    if (delete == 1)
    {
      if (x2 > width || x2< 0 || y2 > height || y2 < 0)
      {
        delete = 2;
      }
    }
    /*if (second > 300)
     delete = 2;*/
  }
}

void reset()
{

  if (scene == 1)
  {
    for (int i=0; i<7; i++)
      for (int j=0; j<7; j++)
      {
        int p = j + i*7;
        if (sc % 2 == 1)
        {
          if (m.get(p).d == 5)
          {
            m.get(p).d =6;
          } else if (m.get(p).d == 6)
          {
            m.get(p).d =5;
          }
        }

        if (m.get(p).d == 9)
        {
          m.get(p).d = 8;
        }
      }
  } else if (scene == 4)
  {
    for (int i=0; i<13; i++)
      for (int j=0; j<9; j++)
      {
        int p = j + i*9;
        if (sc % 2 == 1)
        {
          if (m2.get(p).d == 5)
          {
            m2.get(p).d =6;
          } else if (m2.get(p).d == 6)
          {
            m2.get(p).d =5;
          }
        }

        if (m2.get(p).d == 9)
        {
          m2.get(p).d = 8;
        }
      }
  }
  sc = 0; 
  g.n = 2;
  //0は上、1は左、2は下、3は右、4は空白、5は有効障害物、6は無効障害物、7はスイッチ、8は鍵、(9はゲート、10は敵)
}

//宣言
Gate g;
Enemy e;
int size1 = 49;

//セットアップ
void setup()
{
  bgm1 = "EP.mp3";
  bgm2 = "EP2.mp3";
  bgm3 = "EP3.mp3";

  minim = new Minim(this);

  player = minim.loadFile(bgm1);

  size(2000, 1150);
  b = new ArrayList<Beam>();
  m = new ArrayList<Masu>();
  g = new Gate(1700, 500, 2);
  e = new Enemy(1800, 500, 1);
  m2 = new ArrayList<Masu>();

  //reset();
  for (int i=0; i<7; i++)
    for (int j=0; j<7; j++)
    {
      m.add(new Masu(i, j, 4, 0, 0, left, top));
    }
  //0は上、1は左、2は下、3は右、4は空白、5は有効障害物、6は無効障害物、7はスイッチ、8は鍵、(9はゲート、10は敵)
  //障害物初期位置
  m.get(9).d = 5;
  m.get(14).d = 5;
  m.get(19).d = 5;
  m.get(24).d = 5;
  m.get(27).d = 5;
  m.get(32).d = 5;
  m.get(37).d = 5;

  m.get(2).d = 6;
  m.get(11).d = 6;
  m.get(17).d = 5;
  m.get(22).d = 6;
  //sm.get(25).d = 6;
  m.get(31).d = 5;
  m.get(40).d = 6;
  m.get(41).d = 6;
  m.get(44).d = 6;
  m.get(36).d = 7;
  m.get(8).d = 8;
  m.get(46).d = 8;

  //stage2
  for (int i=0; i<13; i++)
    for (int j=0; j<9; j++)
    {
      m2.add(new Masu(i, j, 4, 0, 0, left2, top2));
    }

  m2.get(3).d = 5;
  m2.get(5).d = 5;
  m2.get(20).d = 5;
  m2.get(22).d = 5;
  m2.get(23).d = 5;
  m2.get(24).d = 5;
  m2.get(25).d = 5;
  m2.get(26).d = 5;
  m2.get(30).d = 5;
  m2.get(39).d = 5;
  m2.get(49).d = 5;
  m2.get(52).d = 5;
  m2.get(63).d = 5;
  m2.get(72).d = 5;
  m2.get(75).d = 5;
  m2.get(76).d = 5;
  m2.get(90).d = 5;
  m2.get(91).d = 5;
  m2.get(102).d = 5;
  m2.get(103).d = 5;
  m2.get(104).d = 5;
  m2.get(54).d = 5;
  m2.get(58).d = 5;
  m2.get(59).d = 5;
  m2.get(105).d = 5;

  m2.get(28).d = 6;
  m2.get(35).d = 6;
  m2.get(36).d = 6;
  m2.get(41).d = 6;
  m2.get(43).d = 6;
  m2.get(46).d = 6;
  m2.get(47).d = 6;
  m2.get(51).d = 6;
  m2.get(56).d = 6;
  m2.get(65).d = 6;
  m2.get(66).d = 6;
  m2.get(85).d = 6;
  m2.get(86).d = 6;
  m2.get(89).d = 6;
  m2.get(96).d = 6;
  m2.get(100).d = 6;
  m2.get(111).d = 6;
  m2.get(113).d = 6;
  m2.get(2).d = 6;
  m2.get(10).d = 6;
  m2.get(62).d = 6;
  m2.get(69).d = 6;
  m2.get(78).d = 6;
  m2.get(115).d = 6;

  m2.get(15).d = 7;
  m2.get(48).d = 7;
  m2.get(106).d = 7;

  m2.get(71).d = 8;
  m2.get(99).d = 8;
  //frameRate(120);
  colorMode(HSB, 360, 100, 100);

  //フォント
  D7 = createFont("DSEG14Classic-Light.ttf", 150);
  S = createFont("symbol-signs.otf", 100);
  //Font = createFont("Meiryo",50);
}


void draw()
{
  if (scene == 0)
  {
    start_scene();
  } else if (scene == 1)
  {
    player.play();
    if ( player.position() >= 64 * 1000)
    {
      player.rewind();
      player.play();
    }

    blendMode(BLEND);
    background(0);

    //ステージの大きさ
    blendMode(ADD);
    stroke(10, 120, 40);


    for (int i=0; i<8; i++)
    {
      /*for (float r = 0.0; r< 1.0; r += 0.1)
       {
       stroke(140, 100, (1.0 - r) * 10);*/
      strokeWeight(1);
      stroke(140, 100, 50);
      line(left+i*100, top, left+i*100, bottom);

      line(left, top+i*100, right, top+i*100);
      //}
    }

    //blendMode(BLEND);

    //text(sc, 200, 200);
    //text(wc, 300, 300);
    //text(b.size(), 300, 600);
    //手数
    fill(140, 100, 100);
    textFont(D7);
    textSize(60);
    textAlign(LEFT, CENTER);
    text("COUNT", 20, 50);
    textAlign(CENTER, CENTER);
    textSize(100);
    text((int)count, 150, 150);
    textSize(20);
    text("START", 900, 490);
    fill(0, 100, 100);
    text("GOAL", 1850, 490);

    //時間
    fill(140, 100, 100);
    textAlign(LEFT, CENTER);
    textSize(60);
    text("TIME", 20, 275);
    textSize(100);

    sec = (millis()-base_time)/1000;
    //min = int(sec/60);
    if (sec < 10)
    {
      text((int)min + ":" + "0" + (int)sec, 110, 375);
    } else if (sec >= 10)
    {
      text((int)min + ":" + (int)sec, 110, 375);
    }
    if (sec >=60)
    {
      base_time = millis();
      min++;
    }

    //プレイヤー
    //fill(255);

    for (float r = 0.0; r< 1.0; r += 0.1)
    {
      noStroke();
      fill(160, 100, (1.0 - r) * 60);
      ellipse(cx, cy, 100 * r, 100 * r);
    }


    //敵
    e.display();

    //ゲート
    g.display();

    //矢印表示

    for (int i =0; i < m.size(); i++)
    {
      m.get(i).display();

      //矢印移動
      //上
      /*if (isMove0 == 1)
       {
       m.get(i).vy = -10;
       }
       if (m.get(i).my <= top + 40)
       {
       m.get(i).vy = 0;
       }
       
       //左
       if (isMove1 == 1)
       {
       m.get(i).vx = -10;
       }
       if (m.get(i).mx <= left + 50)
       {
       m.get(i).vx = 0;
       }
       
       //下
       if (isMove2 == 1)
       {
       m.get(i).vy = 10;
       }
       if (m.get(i).my >= bottom - 50)
       {
       m.get(i).vy = 0;
       }
       
       //右
       if (isMove3 == 1)
       {
       m.get(i).vx = 10;
       }
       if (m.get(i).mx >= right - 50)
       {
       m.get(i).vx = 0;
       }*/
    }




    //ビーム処理
    for (int i = 0; i < b.size(); i++)
    {
      b.get(i).move();
      for (int j = 0; j < m.size(); j++)
      {

        //方向変換
        if (b.get(i).x2 == m.get(j).mx && b.get(i).y2 == m.get(j).my)
        {
          //上
          if (m.get(j).d == 0)
          {
            b.get(i).x2 = m.get(j).mx-1;
            b.get(i).vx2 = 0;

            b.add(new Beam(m.get(j).mx, m.get(j).my, 10, 0, -10, 0, -10));
          }

          //左
          else if (m.get(j).d == 1)
          {
            b.get(i).y2 = m.get(j).my+1;
            b.get(i).vy2 = 0;

            b.add(new Beam(m.get(j).mx, m.get(j).my, 10, -10, 0, -10, 0));
          }

          //下
          else if (m.get(j).d == 2)
          {
            b.get(i).x2 = m.get(j).mx+1;
            b.get(i).vx2 = 0;

            b.add(new Beam(m.get(j).mx, m.get(j).my, 10, 0, 10, 0, 10));
          }

          //右
          else if (m.get(j).d == 3 && b.get(i).vx2 != 10)
          {
            b.get(i).y2 = m.get(j).my-1;
            b.get(i).vy2 = 0;

            b.add(new Beam(m.get(j).mx, m.get(j).my, 10, 10, 0, 10, 0));
          }

          //壁
          else if (m.get(j).d == 5)
          {
            //b.get(i).x2 = m.get(j).mx;
            b.get(i).vx2 = 0;
            b.get(i).vy2 = 0;
            //g.lock();
          }

          //スイッチ
          else if (m.get(j).d == 7)
          {
            for (int k = 0; k<49; k++)
            {
              if (m.get(k).d == 5)
                m.get(k).d = 6;
              else if (m.get(k).d == 6)
                m.get(k).d = 5;
            }
            sc++;
          }


          //鍵
          else if (m.get(j).d == 8)
          {
            g.unlock();
            m.get(j).d = 9;
          }
        }

        //停止
        if (b.get(i).x == m.get(j).mx && b.get(i).y == m.get(j).my)
        {
          if (m.get(j).d == 0)
            b.get(i).vx = 0;
          else if (m.get(j).d == 1)
            b.get(i).vy = 0;
          else if (m.get(j).d == 2)
            b.get(i).vx = 0;
          else if (m.get(j).d == 3 && b.get(i).vx != 10)
            b.get(i).vy = 0;
          else if (m.get(j).d == 5 && b.get(i).vx2 == 0 && b.get(i).vy2 == 0)
          {
            b.get(i).vx = 0;
            b.get(i).vy = 0; 
            //g.turnOff();
            wc++;
            reset();
            //重ならないように
            b.get(i).x = m.get(j).mx + 1;
            b.get(i).y = m.get(j).my + 1;
          } 
          /*else if (m.get(j).d == 6 && b.get(i).vx2 == 0)
           b.get(i).vx = 0;
           else if (m.get(j).d == 6 && b.get(i).vy2 == 0)
           b.get(i).vy = 0;*/
        }
      }

      //ゲート障害
      if (b.get(i).x2 == g.gx && b.get(i).y2 == g.gy && g.n > 0)
      {
        //b.get(i).x2 = g.gx;
        b.get(i).vx2 = 0;
        b.get(i).vy2 = 0;
        //g.lock();
        //g.turnOff();
      }
      if (b.get(i).x == g.gx && b.get(i).y == g.gy && g.n > 0)
      {
        b.get(i).vx = 0;
        b.get(i).vy = 0;
      }

      //敵直撃&クリア
      if (b.get(i).x2 == e.ex && b.get(i).y2 == e.ey && e.life > 0)
      {
        b.get(i).vx2 = 0;
        b.get(i).vy2 = 0;
        e.damaged();
      }
      if (b.get(i).x == e.ex && b.get(i).y == e.ey && e.life == 0)
      {
        b.get(i).vx = 0;
        b.get(i).vy = 0;

        //クリア
        e.clear();
      }


      //消去
      if (b.get(i).delete == 2)
      {
        b.remove(i);
        //g.lock();
        //g.turnOff();
        reset();
      }
    }

    //消去
    if (b.size() >=5)
    {
      b.remove(0);
    }
  } else if (scene == 4)
  {
    stage2();
  }

  //リザルト画面
  else if (scene == 2)
  {

    result();
  }

  //ロード画面
  else if (scene == 3)
  {
    loading();
  }

  //難易度選択画面
  else if (scene == 5)
  {
    select();
  }
}



void keyPressed()
{
  if (scene == 1 || scene == 4)
  {
    /*if (keyCode==UP && cy>top + 50)
     cy-=100;
     
     else if (keyCode==DOWN && cy<bottom - 50)
     cy+=100;*/

    //スペースでビーム
    if (keyCode== ' ')
    {
      if (scene == 1)
      {
        b.add(new Beam(cx, cy, 10, 10, 0, 10, 0));
      } else if (scene == 4)
      {
        b.add(new Beam(cx2, cy2, 10, 10, 0, 10, 0));
      }
    }

    //Rでリセット
    if (keyCode=='R')
    {
      for (int i=0; i<m.size(); i++)
      {
        if (m.get(i).d < 5)
        {
          m.get(i).d = 4;
        }
      }
    }
  }
}

int q = 0;
void mousePressed()
{
  if (scene == 1)
  {
    if (mouseX > left && mouseX < right && mouseY > top && mouseY < bottom)
    {
      int x = (mouseX - left)/100;
      int y = (mouseY - top)/100;
      int p = x * 7 + y;
      if (p <49 && p >= 0)
      {
        if (m.get(p).d < 5)
        {
          m.get(p).d = (m.get(p).d + 1) % 5;
          if (p != q)
          {
            count++;
          }
        }
        q = p;
      }
    }
  } else if (scene == 4)
  {
    if (mouseX > left2 && mouseX < right && mouseY > top2 && mouseY < bottom2)
    {
      int x = (mouseX - left2)/100;
      int y = (mouseY - top2)/100;
      int p = x * 9 + y;
      if (p <m2.size() && p >= 0)
      {
        if (m2.get(p).d < 5)
        {
          m2.get(p).d = (m2.get(p).d + 1) % 5;
          if (p != q)
          {
            count++;
          }
        }
        q = p;
      }
    }
  }
}
