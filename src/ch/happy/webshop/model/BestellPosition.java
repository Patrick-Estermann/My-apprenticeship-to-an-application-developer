package ch.happy.webshop.model;

import java.util.ArrayList;

public class BestellPosition {
	private Integer bestellPosId;
	private Integer artikelId;
	private Integer bestellId;
	
	private ArrayList<BestellPosition> bestellPosition = new ArrayList<BestellPosition>();
	
	public BestellPosition(Integer bestellPosId, Integer artikelId, Integer bestellId) {
		this.bestellPosId = bestellPosId;
		this.artikelId = artikelId;
		this.bestellId = bestellId;
	}
	
	public BestellPosition() {
		
	}
	
	public Integer getBestellPosId() {
		return bestellPosId;
	}
	public void setBestellPosId(Integer bestellPosId) {
		this.bestellPosId = bestellPosId;
	}
	public Integer getArtikelId() {
		return artikelId;
	}
	public void setArtikelId(Integer artikelId) {
		this.artikelId = artikelId;
	}
	public Integer getBestellId() {
		return bestellId;
	}
	public void setBestellId(Integer bestellId) {
		this.bestellId = bestellId;
	}
	public ArrayList<BestellPosition> getBestellPosition() {
		return bestellPosition;
	}
	public void setBestellPosition(ArrayList<BestellPosition> bestellPosition) {
		this.bestellPosition = bestellPosition;
	}

}
