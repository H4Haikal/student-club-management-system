package model;

import java.util.Date;

public class EventItem {
    private String title;
    private String clubName;
    private Date date;
    private String venue;

    public EventItem(String title, String clubName, Date date, String venue) {
        this.title = title;
        this.clubName = clubName;
        this.date = date;
        this.venue = venue;
    }

    // Getters
    public String getTitle() { return title; }
    public String getClubName() { return clubName; }
    public Date getDate() { return date; }
    public String getVenue() { return venue; }
}