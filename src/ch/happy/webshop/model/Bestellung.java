package ch.happy.webshop.model;

import java.util.ArrayList;
import java.util.Date;

public class Bestellung {
	private Integer bestellungId;
	private Date datum = new Date();
	private String bemerkungen;
	private Integer kundeId;
	private Kunde kunde;
	
	private ArrayList<Bestellung> bestellungen = new ArrayList<Bestellung>();
	
	public Bestellung() {
		
	}
	
	public Bestellung(Integer bestellungId, Date datum, String bemerkungen, Integer kundeId) {
	this.bestellungId = bestellungId;
	this.datum = datum;
	this.bemerkungen = bemerkungen;
	this.kundeId = kundeId;
	}

	public Integer getBestellungId() {
		return bestellungId;
	}

	public void setBestellungId(Integer bestellungId) {
		this.bestellungId = bestellungId;
	}

	public Date getDatum() {
		return datum;
	}

	public void setDatum(Date datum) {
		this.datum = datum;
	}

	public String getBemerkungen() {
		return bemerkungen;
	}

	public void setBemerkungen(String bemerkungen) {
		this.bemerkungen = bemerkungen;
	}

	public Integer getKundeId() {
		return kundeId;
	}

	public void setKundeId(Integer kundeId) {
		this.kundeId = kundeId;
	}

	public Kunde getKunde() {
		return kunde;
	}

	public void setKunde(Kunde kunde) {
		this.kunde = kunde;
	}

	public ArrayList<Bestellung> getBestellungen() {
		return bestellungen;
	}

	public void setBestellungen(ArrayList<Bestellung> bestellungen) {
		this.bestellungen = bestellungen;
	}
	
}
