# --------------------------------------------------------------------------------
# Stage 1: Gradle을 사용하여 WAR 파일 빌드 (Build Stage)
# --------------------------------------------------------------------------------
FROM gradle:jdk17 AS build

# 작업 디렉토리 설정
WORKDIR /app

# Gradle Wrapper 파일 복사
COPY gradlew .
COPY gradle ./gradle

# Gradle 빌드 설정 파일 복사
COPY build.gradle .
COPY settings.gradle .

# 소스 코드 복사
COPY src ./src

# gradlew에 실행 권한을 부여하고, WAR 파일 빌드
# bootWar 태스크를 사용하여 Spring Boot 실행 가능한 WAR 파일 생성
RUN chmod +x ./gradlew && ./gradlew bootWar --no-daemon

# --------------------------------------------------------------------------------
# Stage 2: Tomcat 10 이미지를 사용하여 애플리케이션 배포 (Production Stage)
# --------------------------------------------------------------------------------
FROM tomcat:10-jre17-temurin

# Tomcat 기본 웹 애플리케이션 삭제 (ROOT 경로에 배포하기 위해 기존 파일 정리)
RUN rm -rf /usr/local/tomcat/webapps/*

# 빌드 스테이지에서 생성된 WAR 파일을 Tomcat의 webapps 디렉토리에 복사
# 파일 이름을 ROOT.war로 지정하여 서버 시작 시 기본 경로(/)로 접근 가능하게 설정
COPY --from=build /app/build/libs/*.war /usr/local/tomcat/webapps/ROOT.war

# 애플리케이션이 사용하는 포트 노출
EXPOSE 8080

# Spring 프로필을 'prod'로 설정하는 환경 변수 지정
ENV SPRING_PROFILES_ACTIVE=prod

# Tomcat 기본 명령어(catalina.sh run)를 사용하여 서버 실행
CMD ["catalina.sh", "run"]