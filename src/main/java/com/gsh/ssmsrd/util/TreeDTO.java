package com.gsh.ssmsrd.util;

import java.util.List;
import java.util.Map;
/**
    * @Title: TreeDTO
    * @Package com.gsh.ssmsrd.util
    * @Description: 菜单封装类
    * @author gsh
    * @date 2018/7/10 16:01
    */
@SuppressWarnings("ALL")
public class TreeDTO {
		
		private int id ;
		private String text ;
		private String iconCls ;
		private int checked ;
		private int parentId;
		private String state ;
		private List<TreeDTO> children;
		private Map<String, Object> attributes ;
		
		


		public TreeDTO(int id, String text, String iconCls, int checked,
					   int parentId, String state, List<TreeDTO> children,
					   Map<String, Object> attributes) {
			super();
			this.id = id;
			this.text = text;
			this.iconCls = iconCls;
			this.checked = checked;
			this.parentId = parentId;
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
		public int getParentId() {
			return parentId;
		}
		public void setParentId(int parentId) {
			this.parentId = parentId;
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
				", parentId=" + parentId +
				", state='" + state + '\'' +
				", children=" + children +
				", attributes=" + attributes +
				'}';
	}
}
