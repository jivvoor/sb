package kr.java.sb.config;

import kr.java.sb.props.AppProps;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableConfigurationProperties(AppProps.class)
public class PropsConfig {
}
