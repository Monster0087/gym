package com.gym.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

public class MultiTabRequestWrapper extends HttpServletRequestWrapper {
    private String tabId;

    public MultiTabRequestWrapper(HttpServletRequest request, String tabId) {
        super(request);
        this.tabId = tabId;
    }

    @Override
    public HttpSession getSession() {
        return new MultiTabSessionWrapper(super.getSession(), tabId);
    }

    @Override
    public HttpSession getSession(boolean create) {
        HttpSession session = super.getSession(create);
        if (session == null) return null;
        return new MultiTabSessionWrapper(session, tabId);
    }
}
