package com.gym.scratch;

import org.mindrot.jbcrypt.BCrypt;

public class AuthCheck {
    public static void main(String[] args) {
        String hash = "$2a$10$gLKBwvHYxlfJA7C8ilVzKOFANPUBkR/UpEWQZ8qhM/b7DvkzoLNke";
        boolean match = BCrypt.checkpw("Monster@87", hash);
        System.out.println("Match: " + match);
    }
}
