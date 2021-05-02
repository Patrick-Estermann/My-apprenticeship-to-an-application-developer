package ch.happy.webshop.model;


import java.util.ArrayList;
import java.util.Date;

public class Kunde {
	private Integer kundeId;
	private Date kundeSeit = new Date();
	private String nachname;
	private String vorname;
	private String strasse;
	private String ort;
	private String plz;
	private String telefon;
	
	private ArrayList<Kunde> kunden = new ArrayList<Kunde>();

	public Integer getKundeId() {
		return kundeId;
	}

	public void setKundeId(Integer kundeId) {
		this.kundeId = kundeId;
	}

	public Date getKundeSeit() {
		return kundeSeit;
	}

	public void setKundeSeit(Date kundeSeit) {
		this.kundeSeit = kundeSeit;
	}

	public String getNachname() {
		return nachname;
	}

	public void setNachname(String nachname) {
		this.nachname = nachname;
	}

	public String getVorname() {
		return vorname;
	}

	public void setVorname(String vorname) {
		this.vorname = vorname;
	}

	public String getStrasse() {
		return strasse;
	}

	public void setStrasse(String strasse) {
		this.strasse = strasse;
	}

	public String getOrt() {
		return ort;
	}

	public void setOrt(String ort) {
		this.ort = ort;
	}

	public String getPlz() {
		return plz;
	}

	public void setPlz(String plz) {
		this.plz = plz;
	}

	public String getTelefon() {
		return telefon;
	}

	public void setTelefon(String telefon) {
		this.telefon = telefon;
	}

	public ArrayList<Kunde> getKunden() {
		return kunden;
	}

	public void setKunden(ArrayList<Kunde> kunden) {
		this.kunden = kunden;
	}
	
}
