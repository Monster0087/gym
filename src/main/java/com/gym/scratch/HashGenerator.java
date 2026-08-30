package com.gym.scratch;

import org.mindrot.jbcrypt.BCrypt;

public class HashGenerator {
    public static void main(String[] args) {
        String hash = BCrypt.hashpw("Monster@87", BCrypt.gensalt());
        System.out.println("HASH=" + hash);
    }
}
