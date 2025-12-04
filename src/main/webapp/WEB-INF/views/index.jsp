<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메모</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom font for better readability */
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap');
        body {
            font-family: 'Inter', sans-serif;
            background-color: #b4e1bb; /* Darker, organic background color */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }
        /* 노트의 줄무늬 효과를 위한 커스텀 스타일 */
        .lined-paper {
            background-color: #fefeda; /* 종이 색 (약간 미색) */
            /* 배경 이미지로 줄무늬 생성: 25px마다 회색 줄을 그립니다. */
            background-image: linear-gradient(to bottom, transparent 24px, #cbd5e1 25px);
            background-size: 100% 25px;
            line-height: 25px; /* 텍스트 줄 간격을 줄 간격에 맞춥니다. */
            padding-top: 5px; /* 상단 여백 조정 */
            /* min-height를 사용하여 내용에 따라 높이가 늘어나도록 설정 */
            min-height: 128px;
        }
    </style>
</head>
<body>
<!-- 전체 컨테이너를 노트 모양으로 변형 -->
<div class="w-full max-w-lg bg-[#fefeda] p-8 md:p-10 rounded-xl shadow-2xl space-y-8
                transform rotate-1 hover:rotate-0 transition duration-300 ease-in-out border border-gray-200">

    <!-- Header: 클립보드처럼 상단에 제목 배치 -->
    <h1 class="text-3xl font-bold text-gray-800 text-center pb-4 border-b border-gray-300 border-dashed">
        📌 메모
    </h1>

    <!-- Messages Section -->
    <div class="text-center">
        <!-- 메시지 출력 영역 -->
        <p class="text-sm font-medium text-red-600 mb-2">
            <!-- JSP: 서버 메시지를 표시 -->
            <%= request.getAttribute("msg") %>
        </p>

        <div class="lined-paper p-4 rounded-lg shadow-inner text-left text-base text-gray-800 overflow-y-auto min-h-32">
            <p class="font-semibold text-gray-700 mb-1 leading-normal">📝 기록된 내용:</p>

            <%
                // request에서 "memos" 속성 값을 가져와 List<String>으로 캐스팅합니다.
                java.util.List memos = (java.util.List) request.getAttribute("memos");

                if (memos != null && !memos.isEmpty()) {
                    for (Object memoObj : memos) {
                        String content = memoObj.toString(); // List<String> 가정 시 메모 내용 문자열
            %>
            <p class="text-sm text-gray-800 leading-[25px] overflow-hidden whitespace-nowrap overflow-ellipsis">
                • <%= content %>
            </p>
            <%
                }
            } else {
            %>
            <p class="text-sm text-gray-500 italic leading-[25px]">
                아직 기록된 메모가 없습니다.
            </p>
            <%
                }
            %>

        </div>
    </div>

    <!-- Memo Input Form -->
    <form method="post" class="space-y-4">
        <label for="memo-content" class="block text-lg font-medium text-gray-700">새 메모 작성</label>
        <input
                id="memo-content"
                name="content"
                placeholder="노트에 기록할 내용을 입력하세요..."
                class="w-full p-3 border-b-2 border-gray-400 bg-transparent focus:outline-none focus:border-blue-500 transition duration-150 ease-in-out text-gray-800"
                required
        >
        <button
                type="submit"
                class="w-full bg-red-500 text-white font-semibold py-3 rounded-lg hover:bg-red-600 focus:outline-none focus:ring-4 focus:ring-red-300 transition duration-300 ease-in-out transform shadow-md hover:shadow-lg"
        >
            노트에 작성
        </button>
    </form>

    <p class="text-xs text-gray-500 text-center pt-4 border-t border-gray-200 border-dashed mt-4">Simple Note App Integration</p>
</div>
</body>
</html>