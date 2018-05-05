package com.gsh.ssmsrd.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SuppressWarnings("ALL")
public class TreeDTO {
		
		private int id ;
		private String text ;
		private String iconCls ;
		private int checked ;
		private int parent_id ;
		private String state ;
		private List<TreeDTO> children=new ArrayList<TreeDTO>();
		private Map<String, Object> attributes = new HashMap<String, Object>();
		
		


		public TreeDTO(int id, String text, String iconCls, int checked,
                       int parent_id, String state, List<TreeDTO> children,
                       Map<String, Object> attributes) {
			super();
			this.id = id;
			this.text = text;
			this.iconCls = iconCls;
			this.checked = checked;
			this.parent_id = parent_id;
			this.state = state;
			this.children = children;
			this.attributes = attributes;
		}
		public TreeDTO() {
			super();
			// TODO Auto-generated constructor stub
		}
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getText() {
			return text;
		}
		public void setText(String text) {
			this.text = text;
		}
		public String getIconCls() {
			return iconCls;
		}
		public void setIconCls(String iconCls) {
			this.iconCls = iconCls;
		}
		public int getChecked() {
			return checked;
		}
		public void setChecked(int checked) {
			this.checked = checked;
		}
		public int getParent_id() {
			return parent_id;
		}
		public void setParent_id(int parentId) {
			parent_id = parentId;
		}
		public Map<String, Object> getAttributes() {
			return attributes;
		}
		public void setAttributes(Map<String, Object> attributes) {
			this.attributes = attributes;
		}
		public String getState() {
			return state;
		}
		public void setState(String state) {
			this.state = state;
		}
		public List<TreeDTO> getChildren() {
			return children;
		}
		public void setChildren(List<TreeDTO> children) {
			this.children = children;
		}

	@Override
	public String toString() {
		return "TreeDTO{" +
				"id=" + id +
				", text='" + text + '\'' +
				", iconCls='" + iconCls + '\'' +
				", checked=" + checked +
				", parent_id=" + parent_id +
				", state='" + state + '\'' +
				", children=" + children +
				", attributes=" + attributes +
				'}';
	}
}
