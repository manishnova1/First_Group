package com.professor.zebrautility;

public class DemoSleeper {

    private DemoSleeper() {

    }

    public static void sleep(int ms) {
        try {
            Thread.sleep(ms);
        } catch (Exception e) {
            System.out.println("thread errr: ");
            e.printStackTrace();
        }
    }
}
