package com.gym.util;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;
import java.util.Enumeration;

@SuppressWarnings("deprecation")
public class MultiTabSessionWrapper implements HttpSession {
    private final HttpSession session;
    private final String tabId;

    public MultiTabSessionWrapper(HttpSession session, String tabId) {
        this.session = session;
        this.tabId = tabId;
    }

    private String getTabKey(String name) {
        if (tabId == null || tabId.isEmpty() || 
            "requestedUrl".equals(name) || 
            "user".equals(name) || 
            "userId".equals(name) || 
            "userName".equals(name)) {
            return name;
        }
        return name + "_" + tabId;
    }

    @Override
    public Object getAttribute(String name) {
        return session.getAttribute(getTabKey(name));
    }

    @Override
    public void setAttribute(String name, Object value) {
        session.setAttribute(getTabKey(name), value);
    }

    @Override
    public void removeAttribute(String name) {
        session.removeAttribute(getTabKey(name));
    }

    // Delegate other methods
    @Override public long getCreationTime() { return session.getCreationTime(); }
    @Override public String getId() { return session.getId(); }
    @Override public long getLastAccessedTime() { return session.getLastAccessedTime(); }
    @Override public ServletContext getServletContext() { return session.getServletContext(); }
    @Override public void setMaxInactiveInterval(int interval) { session.setMaxInactiveInterval(interval); }
    @Override public int getMaxInactiveInterval() { return session.getMaxInactiveInterval(); }
    @Override public HttpSessionContext getSessionContext() { return session.getSessionContext(); }
    @Override public Object getValue(String name) { return session.getValue(getTabKey(name)); }
    @Override public String[] getValueNames() { return session.getValueNames(); }
    @Override public void putValue(String name, Object value) { session.putValue(getTabKey(name), value); }
    @Override public void removeValue(String name) { session.removeValue(getTabKey(name)); }
    @Override
    public void invalidate() {
        // Invalidate the underlying session to ensure a clean logout across all tabs.
        // The user's expectation of "Logout" is to end the entire session.
        session.invalidate();
    }
    
    @Override public boolean isNew() { return session.isNew(); }
    @Override public Enumeration<String> getAttributeNames() { return session.getAttributeNames(); }
}
