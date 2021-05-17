package egovframework.com.cmm;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;
/**
 * ImagePaginationRenderer.java 클래스
 * 
 * @author 서준식
 * @since 2011. 9. 16.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 16.   서준식       이미지 경로에 ContextPath추가
 * </pre>
 */
public class ImagePaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;
	
	public ImagePaginationRenderer() {
		firstPageLabel    = "<ul><li><a href=\"#\" onclick=\"{0}({1});return false; \"><img src='/images/icon_prevend.gif' border='0'/></a></li>";		
        previousPageLabel = "<li><a href=\"#\" onclick=\"{0}({1});return false; \"><img src='/images/icon_prev.gif' border='0'/></a></li>";        
        currentPageLabel  = "<li><a class='select'>{0}</a></li>";
        otherPageLabel    = "<li><a href=\"#\" onclick=\"{0}({1});return false; \">{2}</a></li>";
        nextPageLabel     = "<li><a href=\"#\" onclick=\"{0}({1});return false; \">	<img src='/images/icon_next.gif' border='0'/></a></li>";        
        lastPageLabel     = "<li><a href=\"#\" onclick=\"{0}({1});return false; \"><img src='/images/icon_nextend.gif' border='0'/></a></li></ul>";   
	}
	
	public void initVariables(){
		
		firstPageLabel    = "<ul><li><a href=\"#\" onclick=\"{0}({1});return false; \"><img src='/images/icon_prevend.gif' border='0'/></a></li>";		
        previousPageLabel = "<li><a href=\"#\" onclick=\"{0}({1});return false; \"><img src='/images/icon_prev.gif' border='0'/></a></li>";        
        currentPageLabel  = "<li><a class='active'>{0}</a></li>";
        otherPageLabel    = "<li><a href=\"#\" onclick=\"{0}({1});return false; \">{2}</a></li>";
        nextPageLabel     = "<li><a href=\"#\" onclick=\"{0}({1});return false; \">	<img src='/images/icon_next.gif' border='0'/></a></li>";        
        lastPageLabel     = "<li><a href=\"#\" onclick=\"{0}({1});return false; \"><img src='/images/icon_nextend.gif' border='0'/></a></li></ul>";        
	}
	


	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
